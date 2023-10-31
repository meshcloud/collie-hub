data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_management_group" "root" {
  name = data.azurerm_subscription.current.tenant_id
}

locals {
  role_definition_name = "Cost Management Contributor"
  role_definition_link = "https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#cost-management-contributor"
}

# data "azuread_users" "billing_users" {
#   # unfortunately mail_nicknames attribute does not work on our AADs because we don't sync from on-premise
#   # so we have to use user prinicpal names for lookups
#   user_principal_names = var.billing_users[*].upn
# }

# todo: it would probably be a lot prettier to create an AAD group for the billing admins and then assign those permissions
# as long as this is all in terraform anyway it doesn't matter much though (terraform destroy is supported still)

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
  role_definition_name = local.role_definition_name
  principal_id         = azuread_group.billing_admins.object_id
  scope                = var.scope
}

# we also assign this permission since its required to read management groups and view the organization hierarchy
resource "azurerm_role_assignment" "management_group_reader" {
  role_definition_name = "Management Group Reader"
  principal_id         = azuread_group.billing_readers.object_id
  scope                = var.scope
}
