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

resource "azuread_group" "billing_admins" {
  display_name     = "cloudfoundation-billing-admins"
  owners           = [data.azuread_client_config.current.object_id]
  members          = toset(data.azuread_users.billing_admins.object_ids)
  security_enabled = true
}

resource "azuread_group" "billing_readers" {
  display_name     = "cloudfoundation-billing-readers"
  owners           = [data.azuread_client_config.current.object_id]
  members          = toset(data.azuread_users.billing_readers.object_ids)
  security_enabled = true
}

resource "azuread_group" "security_auditors" {
  display_name     = "cloudfoundation-security-auditors"
  owners           = [data.azuread_client_config.current.object_id]
  members          = toset(data.azuread_users.security_auditors.object_ids)
  security_enabled = true
}

