locals {
  user_list = split(",", var.users)
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}


data "azuread_user" "users" {
  for_each = toset(local.user_list)
  mail     = trimspace(each.value)
}

resource "azurerm_resource_group" "key_vault" {
  name     = var.key_vault_resource_group_name
  location = var.location
}

resource "azurerm_key_vault" "key_vault" {
  name                          = var.key_vault_name
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
