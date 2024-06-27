---
name: Azure Aviatrix
summary: |
  Set
compliance:
  - control: cfmm/cost-management/monthly-cloud-tenant-billing-report
    statement: |
      Enables
  - control: cfmm/cost-management/billing-alerts
    statement: |
      Sets
---

# Azure Aviatrix

Aviatrix

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.46.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.81.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_app_role_assignment.aviatrix_deploy-approle](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/app_role_assignment) | resource |
| [azuread_app_role_assignment.aviatrix_deploy-directory](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/app_role_assignment) | resource |
| [azuread_application.aviatrix_deploy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_password.aviatrix_deploy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_service_principal.aviatrix_deploy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.aviatrix_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.aviatrix_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [time_rotating.key_rotation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application_published_app_ids) | data source |
| [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_user_group_id"></a> [allowed\_user\_group\_id](#input\_allowed\_user\_group\_id) | id of the authorized id which can do changes | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure location used for creating policy assignments establishing this landing zone's guardrails. | `string` | n/a | yes |
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
