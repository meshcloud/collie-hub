variable "output_md_file" {
  type        = string
  description = "location of the file where this cloud foundation kit module generates its documentation output"
}

resource "local_file" "output_md" {
  filename = var.output_md_file
  content  = <<EOF
The id of the AAD Tenant hosting this platform is `${var.aad_tenant_id}`. All resources deployed under this kit
live under platform management group ${azurerm_management_group.platform.name}.

${module.billing_admins.documentation}

### Region restrictions

This Azure AAD Tenant is configured to only allow resources deployed to the following regions:

${join("\n", formatlist("- %s", var.allowed_locations))}
EOF
}
