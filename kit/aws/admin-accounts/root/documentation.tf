variable "output_md_file" {
  type        = string
  description = "location of the file where this cloud foundation kit module generates its documentation output"
}

resource "local_file" "output_md" {
  filename = var.output_md_file
  content  = <<EOF
The AWS Root Account id is `${var.aws_root_account_id}`.

${module.billing_admins.documentation}

${module.organization_policies.documentation}
EOF
}
