output "security_admins_azuread_group_id" {
  value = azuread_group.security_admins.id
}

output "security_auditors_azuread_group_id" {
  value = azuread_group.security_auditors.id
}
