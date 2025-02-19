output "billing_admins_azuread_group_id" {
  value = azuread_group.billing_admins.object_id
}

output "billing_readers_azuread_group_id" {
  value = azuread_group.billing_readers.object_id
}
