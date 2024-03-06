output "platform_engineers_azuread_group_id" {
  value = azuread_group.platform_engineers.id
}

output "platform_engineers_azuread_group_displayname" {
  value = azuread_group.platform_engineers.display_name
}

output "platform_engineers_members" {
  value = var.platform_engineers_members[*].email
}

output "module_storage_account_resource_id" {
  value = module.terraform_state[0].storage_account_resource_id
}
