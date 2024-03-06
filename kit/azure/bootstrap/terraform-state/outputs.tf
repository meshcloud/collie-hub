output "container_id" {
  description = "Resource manager id of the blob container for storing terraform states"
  value       = azurerm_storage_container.tfstates.resource_manager_id
}

output "resource_group_name" {
  value = azurerm_resource_group.tfstates.name
}

output "storage_account_resource_id" {
  value = azurerm_storage_account.tfstates.id
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstates.name
}

output "container_name" {
  value = azurerm_storage_container.tfstates.name
}

output "location" {
  value = azurerm_resource_group.tfstates.location
}

output "documentation_uami_client_id" {
  value = length(azurerm_user_assigned_identity.docs) > 0 ? azurerm_user_assigned_identity.docs[0].client_id : null
}

output "uami_documentation_name" {
  value = length(azurerm_federated_identity_credential.docs) > 0 ? azurerm_federated_identity_credential.docs[0].name : null
}
