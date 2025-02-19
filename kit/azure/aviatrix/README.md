---
name: Azure Aviatrix Integration
summary: |
  Integrates an Azure subscription with Aviatrix
compliance:
  - control: cfmm/service-ecosystem/virtual-network-service
    statement: This
---

# Azure Aviatrix

Aviatrix

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.0.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.116.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.11.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_app_role_assignment.aviatrix_deploy-approle](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/resources/app_role_assignment) | resource |
| [azuread_app_role_assignment.aviatrix_deploy-directory](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/resources/app_role_assignment) | resource |
| [azuread_application.aviatrix_deploy](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/resources/application) | resource |
| [azuread_application_password.aviatrix_deploy](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/resources/application_password) | resource |
| [azuread_service_principal.aviatrix_deploy](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.aviatrix_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.aviatrix_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_definition) | resource |
| [time_rotating.key_rotation](https://registry.terraform.io/providers/hashicorp/time/0.11.1/docs/resources/rotating) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/data-sources/application_published_app_ids) | data source |
| [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/data-sources/service_principal) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_parent_management_group"></a> [parent\_management\_group](#input\_parent\_management\_group) | id of the tenant management group | `string` | n/a | yes |
| <a name="input_service_principal_name"></a> [service\_principal\_name](#input\_service\_principal\_name) | id of the tenant management group | `string` | `"avaitrix_deploy_spn"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aviatrix_service_principal"></a> [aviatrix\_service\_principal](#output\_aviatrix\_service\_principal) | n/a |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
| <a name="output_client_principal_id"></a> [client\_principal\_id](#output\_client\_principal\_id) | n/a |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | n/a |
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->
