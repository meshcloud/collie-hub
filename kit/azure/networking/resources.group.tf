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

# Set up permissions for deploy user
resource "azurerm_role_definition" "cloudfoundation_tfdeploy" {
  name  = "${var.cloudfoundation}_network"
  scope = data.azurerm_subscription.current.id
  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/write",
      "Microsoft.Resources/subscriptions/resourceGroups/delete",
      # Permissions for log network
      "Microsoft.Network/publicIPPrefixes/*",
      "Microsoft.Network/virtualNetworks/*",
      "Microsoft.Network/networkWatchers/*",
      "Microsoft.Network/networkSecurityGroups/*",
      "Microsoft.Network/routeTables/*"
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
