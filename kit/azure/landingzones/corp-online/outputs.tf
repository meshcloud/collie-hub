output "corp_id" {
  description = "id of the corp management group"
  value       = azurerm_management_group.corp.id
}

output "online_id" {
  description = "id of the online management group"
  value       = azurerm_management_group.online.id
}
