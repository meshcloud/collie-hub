output "documentation" {
  value = <<EOF
### Billing Admins

The following users have the [${local.role_definition_name}](${local.role_definition_link})
on the root management group. This grants access to billing data on the entire AAD Tenant.

${join("\n", formatlist("- %s", var.billing_users[*].email))}
EOF
}
