# creates group and permissions for network admins
resource "azuread_group" "network_admins" {
  display_name     = var.network_admin_group
  description      = "Privileged Cloud Foundation group. Members have access to Azure network resources Logs."
  security_enabled = true
}

resource "azurerm_role_assignment" "network_admins_dns" {
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azuread_group.network_admins.object_id
  scope                = var.connectivity_scope
}

resource "azurerm_role_assignment" "network_admins_connectivity" {
  role_definition_name = "Network Contributor"
  description          = "grant permission for network admins to manage all centrally managed networks"
  principal_id         = azuread_group.network_admins.object_id
  scope                = var.connectivity_scope
}

resource "azurerm_role_assignment" "network_admins_landingzone" {
  role_definition_name = "Network Contributor"
  description          = "grant permission for network admins to manage networks for all landingzones"
  principal_id         = azuread_group.network_admins.object_id
  scope                = var.landingzone_scope
}

resource "azurerm_role_assignment" "network_admins" {
  role_definition_name = "Storage Blob Data Reader"
  description          = "grant permission for network admins to read flow logs"
  principal_id         = azuread_group.network_admins.object_id
  scope                = data.azurerm_subscription.current.id
}


# Set up permissions for deploying to this subscription
resource "azurerm_role_definition" "cloudfoundation_tfdeploy" {
  name  = "${var.cloudfoundation}_network"
  scope = data.azurerm_subscription.current.id
  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/write",
      "Microsoft.Resources/subscriptions/resourceGroups/delete",
      # Permissions for network for the connectivity mg
      "Microsoft.Network/publicIPPrefixes/*",
      "Microsoft.Network/virtualNetworks/*",
      "Microsoft.Network/networkWatchers/*",
      "Microsoft.Network/networkSecurityGroups/*",
      "Microsoft.Network/routeTables/*",
    ]
  }
}

resource "azurerm_role_assignment" "cloudfoundation_tfdeploy" {
  principal_id       = var.cloudfoundation_deploy_principal_id
  scope              = data.azurerm_subscription.current.id
  role_definition_id = azurerm_role_definition.cloudfoundation_tfdeploy.role_definition_resource_id
}
