output "documentation_md" {
  value       = <<EOF
# Building Block - Connectivity

The Connectivity building block deploys a managed VNet that's connected to Likvid Bank's network hub.
This enables on-premise connectivity.

# 🌐 Connectivity Building Block Backplane

This module automates the deployment of a Connectivity building block within Azure. It utilizes service principles for automation. The states of these resources are maintained in a designated storage account.

## 🛠️ Role Definition

| Name | ID |
| --- | --- |
| ${azurerm_role_definition.buildingblock_deploy_hub.name} | ${azurerm_role_definition.buildingblock_deploy_hub.id} |

## 📝 Role Assignments

| Principal ID |
| --- |
| ${join("\n", [for assignment in azurerm_role_assignment.buildingblock_deploy_hub : assignment.principal_id])} |


## 🎯 Scope

- **Scope**: `${var.scope}`

EOF
  description = "Markdown documentation with information about the Connectivity building block backplane"
}

