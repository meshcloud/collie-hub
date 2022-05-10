output "documentation" {
  value = <<EOF
### Organization-wide Service Control Policy

A global [service control policy](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html)
applies to the entire AWS organization. This global policy denies access to all AWS regions except

${join("\n", formatlist("- `%s` ", var.whitelisted_regions))}

The following global services are exempt from this restriction because they require global availability to work as intended

${join("\n", formatlist("- `%s` ", var.whitelisted_global_services))}
EOF
}


