output "tenant_name" {
  value       = var.tenant_name
  description = "The name of the tenant"
}

output "hub_subscription" {
  value       = azurerm_resource_group.spoke_rg.name
  description = "The subscription of the hub virtual network"
}

output "spoke_virtual_network_id" {
  value       = azurerm_virtual_network.spoke_vnet.id
  description = "The ID of the spoke virtual network"
}

output "hub_virtual_network_id" {
  value       = data.azurerm_virtual_network.hub_vnet.id
  description = "The ID of the hub virtual network"
}

output "firewall_name" {
  value = join("", data.azurerm_firewall.fw.*.name)

  description = "The name of the firewall in the spoke network"
}

output "fw_spoke_network_rules" {
  value       = var.firewall_network_rules
  description = "The network rules configured for the firewall in the spoke network"
}

output "fw_spoke_application_rules" {
  value       = var.firewall_application_rules
  description = "The application rules configured for the firewall in the spoke network"
}

output "fw_spoke_nat_rules" {
  value       = var.firewall_nat_rules
  description = "The NAT rules configured for the firewall in the spoke network"
}

