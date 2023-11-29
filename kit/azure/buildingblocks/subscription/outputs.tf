output "subscription" {
  value = resource.azurerm_subscription.sub
}

output "parent_management_group" {
  value = data.azurerm_management_group.lz
}
