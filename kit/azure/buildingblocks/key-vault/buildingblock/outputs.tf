output "key_vault_id" {
  value = azurerm_key_vault.key_vault.id
}

output "key_vault_name" {
  value = azurerm_key_vault.key_vault.name
}

output "key_vault_resource_group" {
  value = azurerm_resource_group.key_vault.name
}
