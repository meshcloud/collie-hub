output "role_definition_id" {
  value       = azurerm_role_definition.buildingblock_deploy_hub.id
  description = "The ID of the role definition that enables deployment of the Connectivity building block to the hub."
}

output "role_definition_name" {
  value       = azurerm_role_definition.buildingblock_deploy_hub.name
  description = "The name of the role definition that enables deployment of the Connectivity building block to the hub."
}

output "role_assignment_ids" {
  value       = { for id in var.principal_ids : id => azurerm_role_assignment.buildingblock_deploy_hub[id].id }
  description = "The IDs of the role assignments for the service principals."
}

output "role_assignment_principal_ids" {
  value       = { for id in var.principal_ids : id => azurerm_role_assignment.buildingblock_deploy_hub[id].principal_id }
  description = "The principal IDs of the service principals that have been assigned the role."
}

output "scope" {
  value       = data.azurerm_subscription.current.id
  description = "The scope where the role definition and role assignments are applied."
}

