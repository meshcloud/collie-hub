output "database_name" {
  description = "The name of the created PostgreSQL database"
  value       = azurerm_postgresql_database.example.name
}

output "database_id" {
  description = "The ID of the created PostgreSQL database"
  value       = azurerm_postgresql_database.example.id
}

