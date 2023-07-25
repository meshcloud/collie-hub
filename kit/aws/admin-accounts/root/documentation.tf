output "documentation_md" {
  value = <<EOF
The AWS Root Account id is `${var.aws_root_account_id}`.

${module.billing_admins.documentation}

${module.organization_policies.documentation}
EOF
}
