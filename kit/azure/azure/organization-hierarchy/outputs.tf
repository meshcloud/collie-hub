output "parent_id" {
  value = data.azurerm_management_group.parent.id
}

output "landingzones_id" {
  value = azurerm_management_group.landingzones.id
}

output "platform_id" {
  value = azurerm_management_group.platform.id
}

output "connectivity_id" {
  value = azurerm_management_group.connectivity.id
}

output "identity_id" {
  value = azurerm_management_group.identity.id
}

output "management_id" {
  value = azurerm_management_group.management.id
}

