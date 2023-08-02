output "output_md" {
  value  = <<EOF
This kit module enforces a restrictions for resource types on management group ${var.management_group_id}.

The restriction is implemented as a blacklist.
The following services are forbidden
${join("\n", formatlist("- %s", var.resource_types_not_allowed))}
EOF
}
