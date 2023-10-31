output "billing_admin_azuread_group_id" {
  value = azuread_group.billing_admins.id
}

output "billing_reader_azuread_group_id" {
  value = azuread_group.billing_readers.id
}
