output "admin_management_group_id" {
  description = "id of the admin management group"
  value       = azurerm_management_group.admin.id
}

output "landingzones_management_group_id" {
  description = "id of the landingzones management group"
  value       = azurerm_management_group.landingzones.id
}