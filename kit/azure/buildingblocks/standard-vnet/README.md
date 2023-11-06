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
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_existing_spn"></a> [existing\_spn](#module\_existing\_spn) | ./module-exisiting-service-principal | n/a |
| <a name="module_existing_sta"></a> [existing\_sta](#module\_existing\_sta) | ./module-existing-storage-account | n/a |
| <a name="module_new_spn"></a> [new\_spn](#module\_new\_spn) | ./module-new-service-principal | n/a |
| <a name="module_new_sta"></a> [new\_sta](#module\_new\_sta) | ./module-new-storage-account | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_new_spn"></a> [create\_new\_spn](#input\_create\_new\_spn) | If you already have an SPN for deployment of Building block in you environment insert '1', otherwise insert '0' so a new one will be created | `number` | n/a | yes |
| <a name="input_create_new_storageaccount"></a> [create\_new\_storageaccount](#input\_create\_new\_storageaccount) | If you already have an Storage Account to keep your terraform state file in you environment insert '1', otherwise insert '0' so a new one will be created | `number` | n/a | yes |
| <a name="input_existing_storage_account_id"></a> [existing\_storage\_account\_id](#input\_existing\_storage\_account\_id) | 'Only required if you want to re-use an existing storage account. This is the resourceId of an existing storage account. You can retrieve this value from panel. | `string` | `null` | no |
| <a name="input_new_resource_group_name"></a> [new\_resource\_group\_name](#input\_new\_resource\_group\_name) | Name of the resource group to create a new storage account inside this RG | `string` | `null` | no |
| <a name="input_spn_suffix"></a> [spn\_suffix](#input\_spn\_suffix) | suffix for the SPN's name. The format is 'building\_blocks.SUFFIX' | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_existing_sta_backend"></a> [existing\_sta\_backend](#output\_existing\_sta\_backend) | n/a |
| <a name="output_new_sta_backend"></a> [new\_sta\_backend](#output\_new\_sta\_backend) | n/a |
| <a name="output_provider_existing_spn"></a> [provider\_existing\_spn](#output\_provider\_existing\_spn) | Please run 'terraform output provider\_existing\_spn' to export the provider configuration using the existing service principal |
| <a name="output_provider_new_spn"></a> [provider\_new\_spn](#output\_provider\_new\_spn) | Please run 'terraform output provider\_new\_spn' to export the provider configuration using this new service principal |
<!-- END_TF_DOCS -->