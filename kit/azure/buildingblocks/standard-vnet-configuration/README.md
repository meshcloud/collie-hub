---
name: Buildingblocks-azure-standard-vnet-config
summary: |
  Prepares the infrastructure to create a new building block definition for "Azure Standard Virtual Network".
---

# Buildingblocks azure virtual network configuration

Using this module, you can either create a new or use an existing **Service Principal** and **Storage Account** for creating a buildingblock definition inside the meshStack.

## How to use
- a "backend.tf" and a "provider.tf" will be generated as an output of this module which then you can drop them as an encrypted input inside your buildingblock definition.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~>1.10.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.45.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.79.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_resource.container](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azuread_application.building_blocks](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_password.building_blocks_application_pw](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_service_principal.building_blocks_spn](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.building_blocks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [local_file.backend](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.provider](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [time_rotating.building_blocks_secret_rotation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azurerm_role_definition.builtin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_storage_account.tfstates](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_subscription.sta_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_tf_config_path"></a> [backend\_tf\_config\_path](#input\_backend\_tf\_config\_path) | n/a | `string` | n/a | yes |
| <a name="input_deployment_scope"></a> [deployment\_scope](#input\_deployment\_scope) | The scope where this service principal have access on. Usually in the format of '/providers/Microsoft.Management/managementGroups/0000-0000-0000' | `string` | n/a | yes |
| <a name="input_provider_tf_config_path"></a> [provider\_tf\_config\_path](#input\_provider\_tf\_config\_path) | n/a | `string` | n/a | yes |
| <a name="input_storage_account_resource_id"></a> [storage\_account\_resource\_id](#input\_storage\_account\_resource\_id) | This is the ID of the storage account resource and it retrievable via panel. It is in the format of '/subscription/<sub\_id>/resourcegroups/<rg\_name>/... | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_tf"></a> [backend\_tf](#output\_backend\_tf) | Generates a config.tf that can be dropped into meshStack's BuildingBlock Definition as an encrypted file input to configure this building block. |
| <a name="output_provider_tf"></a> [provider\_tf](#output\_provider\_tf) | Generates a config.tf that can be dropped into meshStack's BuildingBlockDefinition as an encrypted file input to configure this building block. |
<!-- END_TF_DOCS -->