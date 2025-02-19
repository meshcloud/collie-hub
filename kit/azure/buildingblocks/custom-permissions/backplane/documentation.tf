output "documentation_md" {
  value       = <<EOF
# Building Block - Custom Permissions

The Custom Permissions building block allows platform engineers to apply custom configuration of permission
beyond what's built-in to the meshStack platform. This building block is intended for advanced use cases
where the default meshStack permissions are not sufficient.

# Automation

The backplane contains all infrastructure required to automates the deployment of a Custom Permissions building block within Azure.  It utilizes the common [Azure Building Blocks Automation Infrastructure](./azure-buildingblocks-automation.html)

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
  description = "Markdown documentation with information about the building block"
}

