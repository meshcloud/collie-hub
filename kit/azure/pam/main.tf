data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_management_group" "root" {
  name = data.azurerm_subscription.current.tenant_id
}

data "azuread_users" "billing_admins" {
  user_principal_names = var.billing_admin_members[*].upn
}

data "azuread_users" "billing_readers" {
  user_principal_names = var.billing_reader_members[*].upn
}

data "azuread_users" "security_auditors" {
  user_principal_names = var.security_auditor_members[*].upn
}

data "azuread_users" "security_admins" {
  user_principal_names = var.security_admin_members[*].upn
}

resource "azuread_group_member" "billing_admins" {
  for_each         = toset(data.azuread_users.billing_admins.object_ids)
  group_object_id  = var.billing_admin.group.object_id
  member_object_id = each.value
}

resource "azuread_group_member" "billing_readers" {
  for_each         = toset(data.azuread_users.billing_readers.object_ids)
  group_object_id  = var.billing_reader.group.object_id
  member_object_id = each.value
}

resource "azuread_group_member" "security_auditors" {
  for_each         = toset(data.azuread_users.security_auditors.object_ids)
  group_object_id  = var.security_auditor.group.object_id
  member_object_id = each.value
}

resource "azuread_group_member" "security_admins" {
  for_each         = toset(data.azuread_users.security_admins.object_ids)
  group_object_id  = var.security_admin.group.object_id
  member_object_id = each.value
}
