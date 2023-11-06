data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_management_group" "root" {
  name = data.azurerm_subscription.current.tenant_id
}

locals {
  role_definition_name = "Cost Management Contributor"
}

resource "azuread_group" "billing_admins" {
  display_name     = "cloudfoundation-billing-admins"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

resource "azuread_group" "billing_readers" {
  display_name     = "cloudfoundation-billing-readers"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

resource "azurerm_role_assignment" "cost_management_contributor" {
  role_definition_name = "Cost Management Contributor"
  principal_id         = azuread_group.billing_admins.object_id
  scope                = var.scope
}

# we also assign this permission since its required to read management groups and view the organization hierarchy
resource "azurerm_role_assignment" "management_group_biling_admin" {
  role_definition_name = "Management Group Reader"
  principal_id         = azuread_group.billing_admins.object_id
  scope                = var.scope
}

resource "azurerm_role_assignment" "cost_management_reader" {
  role_definition_name = "Cost Management Reader"
  principal_id         = azuread_group.billing_admins.object_id
  scope                = var.scope
}

resource "azurerm_role_assignment" "management_group_billing_reader" {
  role_definition_name = "Management Group Reader"
  principal_id         = azuread_group.billing_readers.object_id
  scope                = var.scope
}
