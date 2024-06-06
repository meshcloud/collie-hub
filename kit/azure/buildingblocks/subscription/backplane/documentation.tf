output "documentation_md" {
  value       = <<EOF
# Building Block - Subscription

This building block deploys default configuration for a subscription.

- Enforces subscription naming policy
- Ensures subscriptions are placed correctly in the resource hierarchy

# 📚 Subscription Building Block Backplane

This module automates the deployment of a Subscription building block within Azure. It utilizes service principles for automation. The states of these resources are maintained in a designated storage account.

## 🛠️ Role Definition

| Name | ID |
| --- | --- |
| ${azurerm_role_definition.buildingblock_deploy.name} | ${azurerm_role_definition.buildingblock_deploy.id} |

## 📝 Role Assignments

| Principal ID |
| --- |
| ${join("\n", [for assignment in azurerm_role_assignment.buildingblock_deploy : assignment.principal_id])} |


## 🎯 Scope

- **Scope**: `${var.scope}`

EOF
  description = "Markdown documentation with information about the Subscription building block backplane"
}

