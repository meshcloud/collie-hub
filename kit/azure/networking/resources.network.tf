data "azurerm_subscription" "current" {
}

#TODO setting the name doesn't work. Azure says alias is already in use. Importing fails because I can't figure out which alias to use for that.
#TODO: I cant reproduce an error. But the name does not changed from the the old value
resource "azurerm_subscription" "networking" {
  subscription_id   = data.azurerm_subscription.current.subscription_id
  subscription_name = "${var.cloudfoundation}-hub"
}

# resource "azurerm_management_group_subscription_association" "vnet" {
#   subscription_id     = data.azurerm_subscription.current.id
#   management_group_id = var.parent_management_group_id
# }

# Permissions for deploy user on hub subscription
resource "azurerm_role_definition" "cloudfoundation_tfdeploy" {
  name  = var.hub_networking_deploy #TODO definition names are unique per tenant. make it configurable
  scope = data.azurerm_subscription.current.id
  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/write",
      "Microsoft.Resources/subscriptions/resourceGroups/delete",
    ]
  }
}

resource "azurerm_role_assignment" "cloudfoundation_tfdeploy" {
  principal_id       = var.cloudfoundation_deploy_principal_id
  scope              = data.azurerm_subscription.current.id
  role_definition_id = azurerm_role_definition.cloudfoundation_tfdeploy.role_definition_resource_id
}

resource "azurerm_role_assignment" "network_contributor" {
  principal_id         = var.cloudfoundation_deploy_principal_id
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Network Contributor"
}

# Permissions for deploy user on subscription in landing zones management groups
resource "azurerm_role_definition" "cloudfoundation_tfdeploy_lz" {
  name  = var.lz_networking_deploy
  scope = var.scope
  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/write",
      "Microsoft.Resources/subscriptions/resourceGroups/delete",
    ]
  }
}

resource "azurerm_role_assignment" "cloudfoundation_tfdeploy_lz" {
  principal_id       = var.cloudfoundation_deploy_principal_id
  scope              = var.scope
  role_definition_id = azurerm_role_definition.cloudfoundation_tfdeploy_lz.role_definition_resource_id
}

resource "azurerm_role_assignment" "network_contributor_lz" {
  principal_id         = var.cloudfoundation_deploy_principal_id
  scope                = var.scope
  role_definition_name = "Network Contributor"
}

# creates group and permissions for network admins
resource "azuread_group" "network_admins" {
  display_name     = var.network_admin_group
  description      = "Privileged Cloud Foundation group. Members have access to Azure network resources Logs."
  security_enabled = true

}

resource "azurerm_role_assignment" "network_admins_dns" {
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azuread_group.network_admins.object_id
  scope                = var.scope_network_admin
}

resource "azurerm_role_assignment" "network_admins" {
  role_definition_name = "Network Contributor"
  principal_id         = azuread_group.network_admins.object_id
  scope                = var.scope_network_admin
}

# Resources
resource "azurerm_resource_group" "hub_resource_group" {
  name     = var.hub_resource_group
  location = var.location
}

resource "azurerm_network_ddos_protection_plan" "hub" {
  count = var.create_ddos_plan ? 1 : 0

  name                = "${var.hub_vnet_name}-protection-plan"
  location            = var.location
  resource_group_name = azurerm_resource_group.hub_resource_group.name
}

resource "azurerm_virtual_network" "hub_network" {
  name                = var.hub_vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.hub_resource_group.name
  address_space       = tolist([var.address_space])

  dynamic "ddos_protection_plan" {
    for_each = var.create_ddos_plan ? [true] : []
    iterator = ddos
    content {
      id     = azurerm_ddos_protection_plan.hub.id
      enable = true
    }
  }
}

resource "azurerm_resource_group" "netwatcher" {
  count = var.netwatcher != null ? 1 : 0

  name     = "NetworkWatcherRG"
  location = azurerm_resource_group.hub_resource_group.location
}

resource "azurerm_network_watcher" "netwatcher" {
  count = var.netwatcher != null ? 1 : 0

  name                = "NetworkWatcher_${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.netwatcher[0].name
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_storage_account" "flowlogs" {
  name                      = "flowlogs${random_string.resource_code.result}"
  resource_group_name       = azurerm_resource_group.hub_resource_group.name
  location                  = azurerm_resource_group.hub_resource_group.location
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  shared_access_key_enabled = false
}

resource "azurerm_storage_container" "flowlogs" {
  name                  = "flowlogs"
  storage_account_name  = azurerm_storage_account.flowlogs.name
  container_access_type = "private"
}

data "azurerm_monitor_diagnostic_categories" "hub" {
  resource_id = azurerm_virtual_network.hub_network.id
}

resource "azurerm_monitor_diagnostic_setting" "vnet" {
  count = var.diagnostics != null ? 1 : 0

  name               = "vnet-diag"
  target_resource_id = azurerm_virtual_network.hub_network.id
  #log_analytics_workspace_id     = var.netwatcher.log_analytics_workspace_id
  log_analytics_workspace_id = local.parsed_diag.log_analytics_id
  #storage_account_id             = local.parsed_diag.storage_account_id
  #eventhub_authorization_rule_id = local.parsed_diag.event_hub_auth_id
  # For each available log category, check if it should be enabled and set enabled = true if it should.
  # All other categories are created with enabled = false to prevent TF from showing changes happening with each plan/apply.
  # Ref: https://github.com/terraform-providers/terraform-provider-azurerm/issues/7235
  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.hub.log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.hub.metrics
    content {
      category = metric.value
      enabled  = contains(local.parsed_diag.metric, "all") || contains(local.parsed_diag.metric, metric.value)
    }
  }
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub_resource_group.name
  virtual_network_name = azurerm_virtual_network.hub_network.name
  address_prefixes     = [cidrsubnet(var.address_space, 2, 1)]

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

resource "azurerm_subnet" "mgmt" {
  name                 = "Management"
  resource_group_name  = azurerm_resource_group.hub_resource_group.name
  virtual_network_name = azurerm_virtual_network.hub_network.name
  address_prefixes     = [cidrsubnet(var.address_space, 2, 3)]

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

resource "azurerm_network_security_group" "mgmt" {
  name                = "subnet-mgmt-nsg"
  location            = azurerm_resource_group.hub_resource_group.location
  resource_group_name = azurerm_resource_group.hub_resource_group.name
}

resource "azurerm_subnet_network_security_group_association" "mgmt" {
  subnet_id                 = azurerm_subnet.mgmt.id
  network_security_group_id = azurerm_network_security_group.mgmt.id
}

resource "azurerm_network_watcher_flow_log" "mgmt_logs" {
  count = var.netwatcher != null ? 1 : 0

  network_watcher_name      = azurerm_network_watcher.netwatcher[0].name
  resource_group_name       = azurerm_resource_group.netwatcher[0].name
  name                      = "${azurerm_resource_group.hub_resource_group.name}-subnet-mgmt-nsg"
  network_security_group_id = azurerm_network_security_group.mgmt.id
  storage_account_id        = azurerm_storage_account.flowlogs.id
  enabled                   = true
  version                   = 2

  traffic_analytics {
    enabled               = true
    workspace_id          = var.netwatcher.log_analytics_workspace_id_short
    workspace_region      = var.location
    workspace_resource_id = var.netwatcher.log_analytics_workspace_id
  }

  retention_policy {
    days    = 0
    enabled = true
  }
}

data "azurerm_monitor_diagnostic_categories" "mgmt" {
  resource_id = azurerm_network_security_group.mgmt.id
}

resource "azurerm_monitor_diagnostic_setting" "mgmt" {
  count = var.diagnostics != null ? 1 : 0

  name                           = "mgmt-nsg-diag"
  target_resource_id             = azurerm_network_security_group.mgmt.id
  log_analytics_workspace_id     = local.parsed_diag.log_analytics_id
  eventhub_authorization_rule_id = local.parsed_diag.event_hub_auth_id
  #eventhub_name                  = local.parsed_diag.event_hub_auth_id != null ? var.diagnostics.eventhub_name : null
  storage_account_id = local.parsed_diag.storage_account_id

  # For each available metric category, check if it should be enabled and set enabled = true if it should.
  # All other categories are created with enabled = false to prevent TF from showing changes happening with each plan/apply.
  # Ref: https://github.com/terraform-providers/terraform-provider-azurerm/issues/7235
  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.mgmt.log_category_types
    content {
      category = enabled_log.value
      #enabled  = contains(local.parsed_diag.log, "all") || contains(local.parsed_diag.log, log.value)

      #deprecated retention_policy` has been deprecated in favor of `azurerm_storage_management_policy`
      # retention_policy {
      #   days    = 0
      #   enabled = false
      # }
    }
  }
}

resource "azurerm_network_security_rule" "mgmt" {
  count = length(local.merged_mgmt_nsg_rules)

  resource_group_name                        = azurerm_resource_group.hub_resource_group.name
  network_security_group_name                = azurerm_network_security_group.mgmt.name
  priority                                   = 100 + 100 * count.index
  name                                       = local.merged_mgmt_nsg_rules[count.index].name
  direction                                  = local.merged_mgmt_nsg_rules[count.index].direction
  access                                     = local.merged_mgmt_nsg_rules[count.index].access
  protocol                                   = local.merged_mgmt_nsg_rules[count.index].protocol
  description                                = local.merged_mgmt_nsg_rules[count.index].description
  source_port_range                          = local.merged_mgmt_nsg_rules[count.index].source_port_range
  source_port_ranges                         = local.merged_mgmt_nsg_rules[count.index].source_port_ranges
  destination_port_range                     = local.merged_mgmt_nsg_rules[count.index].destination_port_range
  destination_port_ranges                    = local.merged_mgmt_nsg_rules[count.index].destination_port_ranges
  source_address_prefix                      = local.merged_mgmt_nsg_rules[count.index].source_address_prefix
  source_address_prefixes                    = local.merged_mgmt_nsg_rules[count.index].source_address_prefixes
  source_application_security_group_ids      = local.merged_mgmt_nsg_rules[count.index].source_application_security_group_ids
  destination_address_prefix                 = local.merged_mgmt_nsg_rules[count.index].destination_address_prefix
  destination_address_prefixes               = local.merged_mgmt_nsg_rules[count.index].destination_address_prefixes
  destination_application_security_group_ids = local.merged_mgmt_nsg_rules[count.index].destination_application_security_group_ids
}


### routes
resource "azurerm_route_table" "out" {
  name                = "${var.cloudfoundation}-outbound-rt"
  location            = azurerm_resource_group.hub_resource_group.location
  resource_group_name = azurerm_resource_group.hub_resource_group.name
}

resource "azurerm_subnet_route_table_association" "mgmt" {
  subnet_id      = azurerm_subnet.mgmt.id
  route_table_id = azurerm_route_table.out.id
}
