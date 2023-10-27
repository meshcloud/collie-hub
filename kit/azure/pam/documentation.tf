output "documentation_md" {
  value = <<EOF

# Privileged Access Management

The following groups are used for managing privileged access to the cloud foundation.

| Group                          | Membership managed via | Function                      | Object ID      |
|--------------------------------|-------------------------------|-----------------------------------------|
| `${azuread_group.billing_admins.display_name}` | The collie PAM kit in the collie repository | Manage financial aspects of cloud usage and allocate costs to various teams or projects. | ${azuread_group.billing_admins.object_id}   |
| `${azuread_group.billing_readers.display_name}` | The collie PAM kit in the collie repository | View financial aspects of cloud usage and allocate costs to various teams or projects. | ${azuread_group.billing_admins.object_id}   |
| `${azuread_group.security_auditors.display_name}` | The collie PAM kit in the collie repository | Responsible for ensuring compliance and security across cloud resources. | ${azuread_group.security_auditors.object_id} |

The `${azuread_group.billing_admins.display_name}` group has the following members:
${join("\n", formatlist("- %s", var.billing_admin_members[*].email))}

The `${azuread_group.billing_readers.display_name}` group has the following members:
${join("\n", formatlist("- %s", var.billing_reader_members[*].email))}

The `${azuread_group.security_auditors.display_name}` group has the following members:
${join("\n", formatlist("- %s", var.security_auditor_members[*].email))}


Group memberships to the other groups are managed outside of the module. This is more convenient for e.g. granting temporary access for trouble shooting or audit purposes.

EOF
}
