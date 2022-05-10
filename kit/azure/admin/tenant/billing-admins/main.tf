locals {
  role_definition_name = "Cost Management Contributor"
  role_definition_link = "https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#cost-management-contributor"
}

data "azuread_users" "billing_users" {
  # unfortunately mail_nicknames attribute does not work on our AADs because we don't sync from on-premise
  # so we have to use user prinicpal names for lookups
  user_principal_names = var.billing_users[*].upn
}

# todo: it would probably be a lot prettier to create an AAD group for the billing admins and then assign those permissions
# as long as this is all in terraform anyway it doesn't matter much though (terraform destroy is supported still)
resource "azurerm_role_assignment" "cost_management_contributor" {
  for_each             = toset(data.azuread_users.billing_users.object_ids)
  scope                = "/providers/Microsoft.Management/managementGroups/${var.aad_tenant_id}"
  role_definition_name = local.role_definition_name
  principal_id         = each.key
}

# we also assign this permission since its required to read management groups and view the organization hierarchy
resource "azurerm_role_assignment" "management_group_reader" {
  for_each             = toset(data.azuread_users.billing_users.object_ids)
  scope                = "/providers/Microsoft.Management/managementGroups/${var.aad_tenant_id}"
  role_definition_name = "Management Group Reader"
  principal_id         = each.key
}
