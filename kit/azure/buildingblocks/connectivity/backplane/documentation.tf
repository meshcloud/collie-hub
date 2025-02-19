output "documentation_md" {
  value       = <<EOF
# Connectivity

The Connectivity building block deploys a managed VNet that's connected to Likvid Bank's network hub.
This enables on-premise connectivity.

## Automation

We automates the deployment of a Budget Alert building block using the common [Azure Building Blocks Automation Infrastructure](../automation.md).
In order to deploy this building block, this infrastructure receives the following roles.

| Role Name | Description | Permissions |
|-----------|-------------|-------------|
| `${azurerm_role_definition.buildingblock_deploy_hub.name}` | ${azurerm_role_definition.buildingblock_deploy_hub.description} | ${join("<br>", formatlist("- `%s`", azurerm_role_definition.buildingblock_deploy_hub.permissions[0].actions))} |

EOF
  description = "Markdown documentation with information about the Connectivity building block backplane"
}

