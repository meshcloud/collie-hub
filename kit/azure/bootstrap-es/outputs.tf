## outputs for tfstate resources

output "container_id" {
  description = "Resource manager id of the blob container for storing terraform states"
  value       = azurerm_storage_container.tfstate.resource_manager_id
}

output "resource_group_name" {
  value = azurerm_resource_group.tfstate.name
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}

## outputs for sp resources

output "client_id" {
  value = azuread_service_principal.cloudfoundation_deploy.application_id
}

output "client_secret" {
  value     = azuread_service_principal_password.cloudfoundation_deploy.value
  sensitive = true
}

output "client_principal_id" {
  value = azuread_service_principal.cloudfoundation_deploy.id
}
