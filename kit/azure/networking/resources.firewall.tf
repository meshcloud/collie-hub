# There are two variables that determine if a firewall will be deployed and if so, which firewall sku tier is used.
# There is a "deploy_firewall" variable, and one called "firewall_sku_tier" to specify which sku_tier (standard, basic, premium) will be
# created. If the Basic version is selected, an additional Azure Firewall subnet and management IP will be created.
# This enables internal updating/upgrading of the firewall from Azure's side without restricting the bandwidth to
# the limited 250 Mbps. More information is available.
#
# https://learn.microsoft.com/en-us/azure/firewall/deploy-firewall-basic-portal-policy

resource "azurerm_subnet" "firewall" {
  count                = var.deploy_firewall ? 1 : 0
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub_resource_group.name
  virtual_network_name = azurerm_virtual_network.hub_network.name
  address_prefixes     = [cidrsubnet(var.address_space, 2, 0)]
  service_endpoints    = var.service_endpoints
}

resource "azurerm_subnet" "firewallmgmt" {
  count                = var.deploy_firewall && var.firewall_sku_tier == "Basic" ? 1 : 0
  name                 = "AzureFirewallManagementSubnet"
  resource_group_name  = azurerm_resource_group.hub_resource_group.name
  virtual_network_name = azurerm_virtual_network.hub_network.name
  address_prefixes     = [cidrsubnet(var.address_space, 2, 2)]
  service_endpoints    = var.service_endpoints
}

resource "azurerm_route" "fw" {
  count                  = var.deploy_firewall ? 1 : 0
  name                   = "firewall"
  resource_group_name    = azurerm_resource_group.hub_resource_group.name
  route_table_name       = azurerm_route_table.out.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.fw[0].ip_configuration[0].private_ip_address
}

resource "azurerm_public_ip_prefix" "fw" {
  name                = "${var.cloudfoundation}-pip-prefix"
  location            = azurerm_resource_group.hub_resource_group.location
  resource_group_name = azurerm_resource_group.hub_resource_group.name
  prefix_length       = var.public_ip_prefix_length
  zones               = var.firewall_zones
}

resource "random_string" "dns" {
  for_each = local.public_ip_map
  length   = 6
  special  = false
  upper    = false
}

resource "azurerm_public_ip" "fw" {
  for_each = var.deploy_firewall ? local.public_ip_map : {}

  name                = "${var.cloudfoundation}-fw-${each.key}-pip"
  location            = azurerm_resource_group.hub_resource_group.location
  resource_group_name = azurerm_resource_group.hub_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = format("%s%sfw%s", lower(replace(var.cloudfoundation, "/[[:^alnum:]]/", "")), lower(replace(each.key, "/[[:^alnum:]]/", "")), random_string.dns[each.key].result)
  public_ip_prefix_id = azurerm_public_ip_prefix.fw.id
  zones               = var.firewall_zones
}

resource "azurerm_public_ip" "fw_mgmt" {
  for_each            = var.deploy_firewall && var.firewall_sku_tier == "Basic" ? { mgmt = 1 } : {}
  name                = "${var.cloudfoundation}-fw-${each.key}-pip"
  location            = azurerm_resource_group.hub_resource_group.location
  resource_group_name = azurerm_resource_group.hub_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = format("%s%sfw", lower(replace(var.cloudfoundation, "/[[:^alnum:]]/", "")), lower(replace(each.key, "/[[:^alnum:]]/", "")))
  public_ip_prefix_id = azurerm_public_ip_prefix.fw.id
  zones               = var.firewall_zones
}

data "azurerm_monitor_diagnostic_categories" "fw_pip" {
  for_each    = var.deploy_firewall ? local.public_ip_map : {}
  resource_id = azurerm_public_ip.fw[each.key].id
}

resource "azurerm_monitor_diagnostic_setting" "fw_pip" {
  for_each                       = var.diagnostics != null && var.deploy_firewall ? local.public_ip_map : {}
  name                           = "${each.key}-pip-diag"
  target_resource_id             = azurerm_public_ip.fw[each.key].id
  log_analytics_workspace_id     = local.parsed_diag.log_analytics_id
  eventhub_authorization_rule_id = local.parsed_diag.event_hub_auth_id
  storage_account_id             = local.parsed_diag.storage_account_id

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.fw_pip[each.key].logs
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.fw_pip[each.key].metrics
    content {
      category = metric.value
      enabled  = contains(local.parsed_diag.metric, "all") || contains(local.parsed_diag.metric, metric.value)
    }
  }
}

resource "azurerm_firewall" "fw" {
  count               = var.deploy_firewall ? 1 : 0
  name                = "${var.cloudfoundation}-fw"
  location            = azurerm_resource_group.hub_resource_group.location
  resource_group_name = azurerm_resource_group.hub_resource_group.name
  threat_intel_mode   = var.threat_intel_mode
  zones               = var.firewall_zones
  sku_name            = "AZFW_VNet"
  sku_tier            = var.firewall_sku_tier

  dynamic "management_ip_configuration" {
    for_each = var.firewall_sku_tier == "Basic" ? { basic = 1 } : {}
    content {
      name                 = local.mgmt_ip_name
      subnet_id            = azurerm_subnet.firewallmgmt[0].id
      public_ip_address_id = azurerm_public_ip.fw_mgmt["mgmt"].id
    }
  }

  dynamic "ip_configuration" {
    for_each = local.public_ip_map
    iterator = ip
    content {
      name                 = ip.key
      subnet_id            = ip.key == var.public_ip_names[0] ? azurerm_subnet.firewall[0].id : null
      public_ip_address_id = azurerm_public_ip.fw[ip.key].id
    }
  }

  # Avoid changes when adding more public ips manually to firewall
  lifecycle {
    ignore_changes = [
      ip_configuration
    ]
  }
}

data "azurerm_monitor_diagnostic_categories" "fw" {
  count       = var.deploy_firewall ? 1 : 0
  resource_id = azurerm_firewall.fw[0].id
}

resource "azurerm_monitor_diagnostic_setting" "fw" {
  count = var.diagnostics != null && var.deploy_firewall ? 1 : 0

  name                           = "fw-diag"
  target_resource_id             = azurerm_firewall.fw[0].id
  log_analytics_workspace_id     = local.parsed_diag.log_analytics_id
  eventhub_authorization_rule_id = local.parsed_diag.event_hub_auth_id
  eventhub_name                  = local.parsed_diag.event_hub_auth_id != null ? var.diagnostics.eventhub_name : null
  storage_account_id             = local.parsed_diag.storage_account_id

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.fw[0].log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.fw[0].metrics
    content {
      category = metric.value
      enabled  = contains(local.parsed_diag.metric, "all") || contains(local.parsed_diag.metric, metric.value)
    }
  }
}

resource "azurerm_firewall_application_rule_collection" "fw" {
  for_each            = var.deploy_firewall ? local.application_rules : {}
  name                = each.key
  azure_firewall_name = azurerm_firewall.fw[0].name
  resource_group_name = azurerm_resource_group.hub_resource_group.name
  priority            = 100 * (each.value.idx + 1)
  action              = each.value.rule.action

  rule {
    name             = each.key
    source_addresses = each.value.rule.source_addresses
    target_fqdns     = each.value.rule.target_fqdns

    protocol {
      type = each.value.rule.protocol.type
      port = each.value.rule.protocol.port
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "fw" {
  for_each            = var.deploy_firewall ? local.network_rules : {}
  name                = each.key
  azure_firewall_name = azurerm_firewall.fw[0].name
  resource_group_name = azurerm_resource_group.hub_resource_group.name
  priority            = 100 * (each.value.idx + 1)
  action              = each.value.rule.action

  rule {
    name                  = each.key
    source_addresses      = each.value.rule.source_addresses
    destination_ports     = each.value.rule.destination_ports
    destination_addresses = [for dest in each.value.rule.destination_addresses : dest]
    protocols             = each.value.rule.protocols
  }
}

resource "azurerm_firewall_nat_rule_collection" "fw" {
  for_each            = var.deploy_firewall ? local.nat_rules : {}
  name                = each.key
  azure_firewall_name = azurerm_firewall.fw[0].name
  resource_group_name = azurerm_resource_group.hub_resource_group.name
  priority            = 100 * (each.value.idx + 1)
  action              = each.value.rule.action

  rule {
    name                  = each.key
    source_addresses      = each.value.rule.source_addresses
    destination_ports     = each.value.rule.destination_ports
    destination_addresses = [for dest in each.value.rule.destination_addresses : dest]
    protocols             = each.value.rule.protocols
    translated_address    = each.value.rule.translated_address
    translated_port       = each.value.rule.translated_port
  }
}
