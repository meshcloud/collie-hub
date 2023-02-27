resource "azurerm_key_vault" "win_vm" {
  name                        = "win-vm-keyvault"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.aadTenantId
  #soft_delete_retention_days  = "7"
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "spn_access_policy" {
  depends_on = [
    azurerm_key_vault.win_vm
  ]
    key_vault_id = azurerm_key_vault.win_vm.id
    tenant_id = var.aadTenantId
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]
    secret_permissions = [
      "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set",
    ]
    storage_permissions = [
      "Get",
    ]
}

locals {
  keyvault_user_object_id = var.keyvault_user_object_id
}
resource "azurerm_key_vault_access_policy" "keyvault_user_access_policy" {
  depends_on = [
    azurerm_key_vault_access_policy.spn_access_policy
  ]
for_each = local.keyvault_user_object_id
   key_vault_id = azurerm_key_vault.win_vm.id
    tenant_id = var.aadTenantId
    object_id = each.value

    key_permissions = [
      "Get",
    ]
    secret_permissions = [
      "Get", "List",
    ]
    storage_permissions = [
      "Get",
    ]

}

#Create KeyVault VM password
resource "random_password" "winvmpassword" {
  length = 20
  special = true
}
#Create Key Vault Secret
resource "azurerm_key_vault_secret" "winvmpassword" {
  name         = "winvmpassword"
  value        = random_password.winvmpassword.result
  key_vault_id = azurerm_key_vault.win_vm.id
  depends_on = [
    azurerm_key_vault_access_policy.spn_access_policy
  ]
}

data "azurerm_client_config" "current" {}