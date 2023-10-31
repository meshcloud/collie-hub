output "billing_admins_members" {
  value = azuread_group_member.billing_admins.member_object_id
}

output "billing_readers_members" {
  value = azuread_group_member.billing_readers.member_object_id

}

output "security_auditors_members" {
  value = azuread_group_member.security_auditors_members.member_object_id
}
