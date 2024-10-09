output "documentation_md" {
  value       = <<EOF
# Subscription Budget Alert

The Budget Alert Building block configures a simple monthly budget alert for subscriptions.
We highly recommend (and for some landing zones enforce) that application teams set up an alert as a simple
mechanism to prevent unintentional cost overruns.

We encourage application teams to deploy additional alerts with fine-grained notification rules according to the
specific needs of their application and infrastructure.

## Automation

We automate the deployment of a Budget Alert building block using the common [Azure Building Blocks Automation Infrastructure](../automation.md).
In order to deploy this building block, this infrastructure receives the following roles.

| Role Name | Description | Permissions |
|-----------|-------------|-------------|
| `${azurerm_role_definition.buildingblock_deploy.name}` | ${azurerm_role_definition.buildingblock_deploy.description} | ${join("<br>", formatlist("- `%s`", azurerm_role_definition.buildingblock_deploy.permissions[0].actions))} |

EOF
  description = "Markdown documentation with information about the Budget Alert building block backplane"
}

