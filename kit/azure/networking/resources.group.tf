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

resource "azurerm_role_assignment" "network_admins" {
  role_definition_name = "Network Contributor"
  principal_id         = azuread_group.network_admins.object_id
  scope                = var.connectivity_scope
}
