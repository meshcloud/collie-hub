output "documentation_md" {
  value = <<EOF
The id of the AAD Tenant hosting this platform is `${var.aad_tenant_id}`.

${module.billing_admins.documentation}

EOF
}
