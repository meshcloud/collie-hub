output "corp_id" {
  description = "id of the corp management group"
  value       = azurerm_management_group.corp.id
}

output "corp_dev_id" {
  description = "id of the corp dev management group"
  value       = azurerm_management_group.dev.id
}

output "corp_prod_id" {
  description = "id of the corp prod  management group"
  value       = azurerm_management_group.prod.id
}

output "online_id" {
  description = "id of the online management group"
  value       = azurerm_management_group.online.id
}
