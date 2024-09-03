output "documentation_md" {
  value = <<EOF

# 🏗️ Building Blocks Automation Infrastructure

This module automates the deployment of building blocks within Azure. It utilizes service principles for automation. The states of these resources are maintained in a designated storage account.

## 🛠️ Service Principal

| Name | ID | Client ID |
| --- | --- | --- |
| `${azuread_service_principal.buildingblock.display_name}` | `${azuread_service_principal.buildingblock.id}` | `${azuread_service_principal.buildingblock.client_id}` |

## 🗃️ Storage Account

| Resource Group | Name | Container Name |
| --- | --- | --- |
| `${azurerm_resource_group.tfstates.name}` | `${azurerm_storage_account.tfstates.name}` | `${azurerm_storage_container.tfstates.name}` |

EOF
}

