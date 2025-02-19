output "tenant_id" {
  value = data.azurerm_subscription.current.tenant_id
}

output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}

output "resource_group_name" {
  value = azurerm_resource_group.tfstates.name
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstates.name
}

output "container_name" {
  value = azurerm_storage_container.tfstates.name
}

output "resource_manager_id" {
  value = azurerm_storage_container.tfstates.resource_manager_id
}

output "principal_id" {
  value = azuread_service_principal.buildingblock.object_id
}

output "client_id" {
  value = azuread_service_principal.buildingblock.client_id
}

output "client_secret" {
  value     = azuread_service_principal_password.buildingblock.value
  sensitive = true
}

