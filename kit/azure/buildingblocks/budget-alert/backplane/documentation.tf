output "documentation_md" {
  value       = <<EOF
# Building Block - Subscription Budget Alert

The Budget Alert Building block configures a simple monthly budget alert for subscriptions.
We highly recommend (and for some landing zones enforce) that application teams set up an alert as a simple
mechanism to prevent unintentional cost overruns.

We encourage application teams to deploy additional alerts with fine-grained notification rules according to the
specific needs of their application and infrastructure.

# 💰 Budget Alert Building Block Backplane

This module automates the deployment of a Budget Alert building block within Azure. It utilizes service principles for automation. The states of these resources are maintained in a designated storage account.

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
  description = "Markdown documentation with information about the Budget Alert building block backplane"
}

