variable "output_md_file" {
  type        = string
  description = "location of the file where this cloud foundation kit module generates its documentation output"
}

resource "local_file" "output_md" {
  filename = var.output_md_file
  content  = <<EOF

### Region restrictions

This Azure AAD Tenant is configured to only allow resources deployed to the following regions:

${join("\n", formatlist("- %s", var.allowed_locations))}
EOF
}
