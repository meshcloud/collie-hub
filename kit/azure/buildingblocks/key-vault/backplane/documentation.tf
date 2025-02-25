output "documentation_md" {
  value       = <<EOF
# Key Vault Building Block

The Key Vault Building Block configures a vault for your subscriptions.

## Automation

We automate the deployment of a Key Vault Building Block building block using the common [Azure Building Blocks Automation Infrastructure](../automation.md).
In order to deploy this building block, this infrastructure receives the following roles.

| Role Name | Description | Permissions |
|-----------|-------------|-------------|
| `${azurerm_role_definition.buildingblock_deploy.name}` | ${azurerm_role_definition.buildingblock_deploy.description} | ${join("<br>", formatlist("- `%s`", azurerm_role_definition.buildingblock_deploy.permissions[0].actions))} |

EOF
  description = "Markdown documentation with information about the Key Vault Building Block building block backplane"
}

