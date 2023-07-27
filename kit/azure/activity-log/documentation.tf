
output "documentation_md" {
  value  = <<EOF

# Active Policies

- **${data.azurerm_policy_definition.activity_log.display_name}**: ${data.azurerm_policy_definition.activity_log.description}

EOF
}
