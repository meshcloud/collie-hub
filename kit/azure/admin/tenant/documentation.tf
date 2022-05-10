variable "output_md_file" {
  type        = string
  description = "location of the file where this cloud foundation kit module generates its documentation output"
}

resource "local_file" "output_md" {
  filename = var.output_md_file
  content  = <<EOF
The id of the AAD Tenant hosting this platform is `${var.aad_tenant_id}`.

${module.organization_policies.documentation}
${module.billing_admins.documentation}
EOF
}