---
name: Building Blocks Automation Infrastructure
summary: |
  Sets up a simple automation infrastructure for building blocks.
# optional: add additional metadata about implemented security controls
---

# Building Blocks Automation Infrastructure

This documentation is intended as a reference documentation for cloud foundation or platform engineers using this module.

The biggest problem is resource group deletion. We need to be able to CRUD exclusively owned RGs in customer subscriptions.
That means we need delete RG permission. But that allows deleting every resource.

Approaches that don't work to limit them

- restrict deletion with `denyAction` unfortunately a dead end since Policy Definitions can't filter on principal ids, so the policy would deny deletion of all RGs
- assigning only create RG permission on MG, then assign Owner role on created RG to allow deletion. Problem is that `terraform destroy` will first destroy the role assignment, then attempt to delete the RG (which is now missing permission). terraform `prevent_destroy` on the role assignment does not work because this fails terraform plans invoked with `terraform destroy`.
-

The only alternatives I see

- customers must supply the RGs, so that the SPN does not have to own their lifecycle and does not need the delete RG permission
- Azure Policy/ABAC becomes powerful enough one day to restrict this (especially: denyAction)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.0.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.116.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.11.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_app_role_assignment.buildingblock-directory](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/resources/app_role_assignment) | resource |
| [azuread_application.buildingblock](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/resources/application) | resource |
| [azuread_service_principal.buildingblock](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.buildingblock](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/resources/service_principal_password) | resource |
| [azurerm_management_group_policy_assignment.buildingblock_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_policy_definition.buildingblock_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/policy_definition) | resource |
| [azurerm_resource_group.tfstates](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.buildingblock_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.keyvault_administrator](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.tfstates_engineers](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.buildingblock_plan](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_definition) | resource |
| [azurerm_storage_account.tfstates](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/storage_account) | resource |
| [azurerm_storage_container.tfstates](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/storage_container) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/string) | resource |
| [time_rotating.key_rotation](https://registry.terraform.io/providers/hashicorp/time/0.11.1/docs/resources/rotating) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/data-sources/application_published_app_ids) | data source |
| [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/data-sources/service_principal) | data source |
| [azurerm_key_vault.cf_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/key_vault) | data source |
| [azurerm_role_definition.keyvault_administrator](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | Key Vault configuration | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location for deploying the storage account | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | n/a | `string` | n/a | yes |
| <a name="input_service_principal_name"></a> [service\_principal\_name](#input\_service\_principal\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | n/a |
| <a name="output_container_name"></a> [container\_name](#output\_container\_name) | n/a |
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_resource_manager_id"></a> [resource\_manager\_id](#output\_resource\_manager\_id) | n/a |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | n/a |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | n/a |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | n/a |
<!-- END_TF_DOCS -->