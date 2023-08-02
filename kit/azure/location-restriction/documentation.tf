output "output_md" {
  value  = <<EOF
This kit module enforces a restrictions for resource and resource group locations on management group ${var.management_group_id}.

The restriction is implemented as a whitelist.
The following locations are allowed
${join("\n", formatlist("- %s", var.allowed_locations))}
EOF
}
