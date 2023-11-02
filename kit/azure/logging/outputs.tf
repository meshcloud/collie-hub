output "security_admins_azuread_group_id" {
  value = azuread_group.security_admins.id
}

output "security_admins_azuread_group_displayname" {
  value = azuread_group.security_admins.display_name
}

output "security_auditors_azuread_group_id" {
  value = azuread_group.security_auditors.id
}

output "security_auditors_azuread_group_displayname" {
  value = azuread_group.security_auditors.display_name
}
