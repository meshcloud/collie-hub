locals {
  admins  = { for user in var.users : user.username => user if contains(user["roles"], "admin") }
  editors = { for user in var.users : user.username => user if contains(user["roles"], "user") }
  readers = { for user in var.users : user.username => user if contains(user["roles"], "reader") }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

data "azuread_user" "users" {
  for_each = merge(local.admins, local.readers)
  mail     = each.value.username
}

resource "azurerm_resource_group" "key_vault" {
  name     = var.key_vault_resource_group_name
  location = var.location
}

resource "azurerm_key_vault" "key_vault" {
  name                          = "${var.key_vault_name}-${random_string.resource_code.result}"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.key_vault.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "standard"
  soft_delete_retention_days    = 7
  purge_protection_enabled      = true
  enable_rbac_authorization     = true
  public_network_access_enabled = var.public_network_access_enabled
}

data "azurerm_role_definition" "keyvault" {
  name = "Key Vault Administrator"
}

resource "azurerm_role_assignment" "cloudfoundation_tfdeploy" {
  for_each             = data.azuread_user.users
  principal_id         = each.value.object_id
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = data.azurerm_role_definition.keyvault.name
}
