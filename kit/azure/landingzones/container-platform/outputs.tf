output "management_id" {
  value = azurerm_management_group.container_platform.id
}

output "management_display_name" {
  value = azurerm_management_group.container_platform.display_name
}

output "dev_management_id" {
  value = azurerm_management_group.dev.id
}

output "dev_management_display_name" {
  value = azurerm_management_group.dev.display_name
}

output "prod_management_id" {
  value = azurerm_management_group.prod.id
}

output "prod_management_display_name" {
  value = azurerm_management_group.prod.display_name
}

output "policy_container_platform_assignments" {
  value = module.policy_container_platform.policy_assignments
}

output "policy_container_platform_dev_assignments" {
  value = module.policy_container_platform_dev.policy_assignments
}

output "policy_container_platform_prod_assignments" {
  value = module.policy_container_platform_prod.policy_assignments
}
