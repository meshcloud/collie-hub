output "postgresql_server_name" {
  description = "The name of the PostgreSQL server"
  value       = azurerm_postgresql_server.example.name
}

output "postgresql_fqdn" {
  description = "The fully qualified domain name of the PostgreSQL server"
  value       = azurerm_postgresql_server.example.fqdn
}

output "postgresql_admin_username" {
  description = "The administrator username for PostgreSQL"
  value       = azurerm_postgresql_server.example.administrator_login
}

output "postgresql_version" {
  description = "The PostgreSQL version"
  value       = azurerm_postgresql_server.example.version
}

output "psql_admin_password" {
  description = "The administrator password for PostgreSQL"
  value       = random_password.psql_admin_password.result
  sensitive   = true
}

output "resource_group_name" {
  description = "The name of the resource group in which the PostgreSQL database is created"
  value       = azurerm_resource_group.example.name
}
