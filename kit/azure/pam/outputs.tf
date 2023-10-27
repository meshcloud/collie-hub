output "billing_admins_azuread_group_id" {
  value = azuread_group.billing_admins.id
}

output "billing_readers_azuread_group_id" {
  value = azuread_group.billing_readers.id
}

output "security_auditors_azuread_group_id" {
  value = azuread_group.security_auditors.id
}
