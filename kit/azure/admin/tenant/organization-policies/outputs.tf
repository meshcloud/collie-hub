output "documentation" {
  value = <<EOF
### Region restrictions

This Azure AAD Tenant is configured to only allow resources deployed to the following regions:

${join("\n", formatlist("- %s", var.allowed_locations))}
EOF
}
