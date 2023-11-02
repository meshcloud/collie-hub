output "billing_admins_azuread_group_id" {
  value = azuread_group.billing_admins.id
}
output "billing_admins_azuread_group_displayname" {
  value = azuread_group.billing_admins.display_name
}
output "billing_readers_azuread_group_id" {
  value = azuread_group.billing_readers.id
}
output "billing_readers_azuread_group_displayname" {
  value = azuread_group.billing_readers.display_name
}
