output "documentation_md" {
  value       = <<EOF
# Subscription

This building block deploys default configuration for a subscription.

- Enforces subscription naming policy
- Ensures subscriptions are placed correctly in the resource hierarchy

# Automation

We automates the deployment of a Budget Alert building block using the common [Azure Building Blocks Automation Infrastructure](../automation.md).
In order to deploy this building block, this infrastructure receives the following roles.

| Role Name | Description | Permissions |
|-----------|-------------|-------------|
| `${azurerm_role_definition.buildingblock_deploy.name}` | ${azurerm_role_definition.buildingblock_deploy.description} | ${join("<br>", formatlist("- `%s`", azurerm_role_definition.buildingblock_deploy.permissions[0].actions))} |


EOF
  description = "Markdown documentation with information about the Subscription building block backplane"
}

