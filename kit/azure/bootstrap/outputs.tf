output "platform_engineers_azuread_group_id" {
  value = azuread_group.platform_engineers.id
}

output "platform_engineers_azuread_group_displayname" {
  value = azuread_group.platform_engineers.display_name
}

output "platform_engineers_members" {
  value = var.platform_engineers_members[*].email
}

output "module_storage_account_resource_id" {
  value = module.terraform_state.storage_account_resource_id
}

output "parent_management_group" {
  value = data.azurerm_management_group.parent.name
}

output "documentation_uami_client_id" {
  value = length(azurerm_user_assigned_identity.docs) > 0 ? azurerm_user_assigned_identity.docs[0].client_id : null
}

output "validation_uami_client_id" {
  value = length(azurerm_user_assigned_identity.validation) > 0 ? azurerm_user_assigned_identity.validation[0].client_id : null
}

output "azurerm_key_vault" {
  value = azurerm_key_vault.key_vault
}

output "azurerm_key_vault_rg_name" {
  value = azurerm_resource_group.key_vault.name
}
