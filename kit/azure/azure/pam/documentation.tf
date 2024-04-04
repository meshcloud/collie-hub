output "documentation_md" {
  value = <<EOF
# Privileged Access Management

The following groups are used for managing privileged access to the cloud foundation.

We include a central listing of these groups and their membersin them because it provides a central overview of
everyone involved with the cloud foundation operation.

|Group|Members|Function|
|-|-|-|
${join("\n", [for g in local.groups : "| **${g.display_name}** | ${join("<br>", g.members)} | ${g.description} |"])}
EOF
}
