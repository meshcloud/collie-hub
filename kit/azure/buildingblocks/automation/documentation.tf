output "documentation_md" {
  value = <<EOF

# 🏗️ Building Blocks Automation Infrastructure

The Likvid Bank Cloud Foundation team maintains a set of building blocks to help application teams get started on the cloud quickly
and provide common services to all application teams.

We use some common infrastructure to automate deployment of building blocks from meshStack.

## 🛠️ Service Principal

The building block automation infrastructure uses a service principal to deploy building blocks.
Each building block definition creates the necessary roles and assigns them to this service principal, so that it
has the right permissions to deploy the building block implementation to a target subscription.

| Name | ID | Client ID |
| --- | --- | --- |
| `${azuread_service_principal.buildingblock.display_name}` | `${azuread_service_principal.buildingblock.object_id}` | `${azuread_service_principal.buildingblock.client_id}` |

## 🗃️ Storage Account

We maintain all terraform states of deployed building blocks in a central storage account.

| Resource Group | Name | Container Name |
| --- | --- | --- |
| `${azurerm_resource_group.tfstates.name}` | `${azurerm_storage_account.tfstates.name}` | `${azurerm_storage_container.tfstates.name}` |

EOF
}

