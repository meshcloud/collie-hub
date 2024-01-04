resource "azurerm_public_ip_prefix" "fw" {
  name                = "${var.cloudfoundation}-pip-prefix"
  location            = azurerm_resource_group.hub_resource_group.location
  resource_group_name = azurerm_resource_group.hub_resource_group.name
  prefix_length       = var.public_ip_prefix_length
  zones               = var.firewall_zones
}

resource "random_string" "dns" {
  for_each = local.public_ip_map

  length  = 6
  special = false
  upper   = false
}

resource "azurerm_public_ip" "fw" {
  for_each = var.firewall_bool ? local.public_ip_map : {}

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
  for_each = var.firewall_bool && var.firewall_sku_tier == "Basic" ? local.mgmt_ip_map : {}

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
  for_each = var.firewall_bool ? local.public_ip_map : {}

  resource_id = azurerm_public_ip.fw[each.key].id
}


resource "azurerm_monitor_diagnostic_setting" "fw_pip" {
  for_each = var.diagnostics != null && var.firewall_bool ? local.public_ip_map : {}

  name                           = "${each.key}-pip-diag"
  target_resource_id             = azurerm_public_ip.fw[each.key].id
  log_analytics_workspace_id     = local.parsed_diag.log_analytics_id
  eventhub_authorization_rule_id = local.parsed_diag.event_hub_auth_id
  #eventhub_name                  = local.parsed_diag.event_hub_auth_id != null ? var.diagnostics.eventhub_name : null
  storage_account_id = local.parsed_diag.storage_account_id

  # For each available metric category, check if it should be enabled and set enabled = true if it should.
  # All other categories are created with enabled = false to prevent TF from showing changes happening with each plan/apply.
  # Ref: https://github.com/terraform-providers/terraform-provider-azurerm/issues/7235
  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.fw_pip[each.key].logs
    content {
      category = enabled_log.value

      #deprecated retention_policy` has been deprecated in favor of `azurerm_storage_management_policy`
      #retention_policy {
      #  days    = 0
      #  enabled = false
      #}
    }
  }
  # For each available metric category, check if it should be enabled and set enabled = true if it should.
  # All other categories are created with enabled = false to prevent TF from showing changes happening with each plan/apply.
  # Ref: https://github.com/terraform-providers/terraform-provider-azurerm/issues/7235
  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.fw_pip[each.key].metrics
    content {
      category = metric.value
      enabled  = contains(local.parsed_diag.metric, "all") || contains(local.parsed_diag.metric, metric.value)

      #deprecated retention_policy` has been deprecated in favor of `azurerm_storage_management_policy`
      # retention_policy {
      #   days    = 0
      #   enabled = false
      # }
    }
  }
}
#
resource "azurerm_firewall" "fw" {
  count               = var.firewall_bool ? 1 : 0
  name                = "${var.cloudfoundation}-fw"
  location            = azurerm_resource_group.hub_resource_group.location
  resource_group_name = azurerm_resource_group.hub_resource_group.name
  threat_intel_mode   = var.threat_intel_mode
  zones               = var.firewall_zones
  sku_name            = "AZFW_VNet"
  sku_tier            = var.firewall_sku_tier

  dynamic "management_ip_configuration" {
    for_each = var.firewall_sku_tier == "Basic" ? local.mgmt_ip_map : {}
    iterator = ip
    content {
      name                 = ip.key
      subnet_id            = ip.key == var.mgmt_ip_names[0] ? azurerm_subnet.firewallmgmt[0].id : null
      public_ip_address_id = azurerm_public_ip.fw_mgmt[ip.key].id
    }
  }

  dynamic "ip_configuration" {
    for_each = local.public_ip_map
    iterator = ip
    content {
      name                 = ip.key
      subnet_id            = ip.key == var.public_ip_names[0] ? azurerm_subnet.firewall.id : null
      public_ip_address_id = azurerm_public_ip.fw[ip.key].id
    }
  }

  # Avoid changes when adding more public ips manually to firewall
  lifecycle {
    ignore_changes = [
      ip_configuration,
      # management_ip_configuration,
    ]
  }
}

#
# data "azurerm_monitor_diagnostic_categories" "fw" {
#   resource_id = azurerm_firewall.fw.id
# }
#
# resource "azurerm_monitor_diagnostic_setting" "fw" {
#   count = var.diagnostics != null ? 1 : 0
#
#   name                           = "fw-diag"
#   target_resource_id             = azurerm_firewall.fw.id
#   log_analytics_workspace_id     = local.parsed_diag.log_analytics_id
#   eventhub_authorization_rule_id = local.parsed_diag.event_hub_auth_id
#   eventhub_name                  = local.parsed_diag.event_hub_auth_id != null ? var.diagnostics.eventhub_name : null
#   storage_account_id             = local.parsed_diag.storage_account_id
#
#   # For each available metric category, check if it should be enabled and set enabled = true if it should.
#   # All other categories are created with enabled = false to prevent TF from showing changes happening with each plan/apply.
#   # Ref: https://github.com/terraform-providers/terraform-provider-azurerm/issues/7235
#   dynamic "log" {
#     for_each = data.azurerm_monitor_diagnostic_categories.fw.log_category_types
#     content {
#       category = log.value
#       enabled  = contains(local.parsed_diag.log, "all") || contains(local.parsed_diag.log, log.value)
#
#       retention_policy {
#         days    = 0
#         enabled = false
#       }
#     }
#   }
#
#   # For each available metric category, check if it should be enabled and set enabled = true if it should.
#   # All other categories are created with enabled = false to prevent TF from showing changes happening with each plan/apply.
#   # Ref: https://github.com/terraform-providers/terraform-provider-azurerm/issues/7235
#   dynamic "metric" {
#     for_each = data.azurerm_monitor_diagnostic_categories.fw.metrics
#     content {
#       category = metric.value
#       enabled  = contains(local.parsed_diag.metric, "all") || contains(local.parsed_diag.metric, metric.value)
#
#       retention_policy {
#         days    = 0
#         enabled = false
#       }
#     }
#   }
# }
#
# resource "azurerm_firewall_application_rule_collection" "fw" {
#   for_each = local.application_rules
#
#   name                = each.key
#   azure_firewall_name = azurerm_firewall.fw.name
#   resource_group_name = azurerm_resource_group.hub_resource_group.name
#   priority            = 100 * (each.value.idx + 1)
#   action              = each.value.rule.action
#
#   rule {
#     name             = each.key
#     source_addresses = each.value.rule.source_addresses
#     target_fqdns     = each.value.rule.target_fqdns
#
#     protocol {
#       type = each.value.rule.protocol.type
#       port = each.value.rule.protocol.port
#     }
#   }
# }
#
# resource "azurerm_firewall_network_rule_collection" "fw" {
#   for_each = local.network_rules
#
#   name                = each.key
#   azure_firewall_name = azurerm_firewall.fw.name
#   resource_group_name = azurerm_resource_group.hub_resource_group.name
#   priority            = 100 * (each.value.idx + 1)
#   action              = each.value.rule.action
#
#   rule {
#     name                  = each.key
#     source_addresses      = each.value.rule.source_addresses
#     destination_ports     = each.value.rule.destination_ports
#     destination_addresses = [for dest in each.value.rule.destination_addresses : contains(var.public_ip_names, dest) ? azurerm_public_ip.fw[dest].ip_address : dest]
#     protocols             = each.value.rule.protocols
#   }
# }
#
# resource "azurerm_firewall_nat_rule_collection" "fw" {
#   for_each = local.nat_rules
#
#   name                = each.key
#   azure_firewall_name = azurerm_firewall.fw.name
#   resource_group_name = azurerm_resource_group.hub_resource_group.name
#   priority            = 100 * (each.value.idx + 1)
#   action              = each.value.rule.action
#
#   rule {
#     name                  = each.key
#     source_addresses      = each.value.rule.source_addresses
#     destination_ports     = each.value.rule.destination_ports
#     destination_addresses = [for dest in each.value.rule.destination_addresses : contains(var.public_ip_names, dest) ? azurerm_public_ip.fw[dest].ip_address : dest]
#     protocols             = each.value.rule.protocols
#     translated_address    = each.value.rule.translated_address
#     translated_port       = each.value.rule.translated_port
#   }
# }
