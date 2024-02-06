output "hub_subscription" {
  value       = data.azurerm_subscription.current.subscription_id
  description = "Subscription of hub vnet"
}

output "hub_location" {
  value       = var.location
  description = "Location of hub vnet"
}

output "hub_rg" {
  value       = azurerm_resource_group.hub_resource_group.name
  description = "Resource Group of hub vnet"
}

output "hub_vnet" {
  value       = azurerm_virtual_network.hub_network.name
  description = "Name of hub vnet"
}

output "firewall_name" {
  value       = join("", azurerm_firewall.fw.*.name)
  description = "Name of hub vnet"
}

output "network_admins_azuread_group_id" {
  value = azuread_group.network_admins.id
}
