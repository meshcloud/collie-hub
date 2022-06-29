---
name: Azure Platform Bootstrap
summary: |
  creates a service principal with permissions to deploy the cloud foundation infrastructure.
  This is a "bootstrap" module, which means that it must be manually executed once by an administrator
  to bootstrap the cloudfoundation
cfmm: 
  - block: iam/privileged-access-management
    description: |
      The deploy user has privileged access to the cloud foundation infrastructure.
      Access to the credentials of this user are carefully controlled via...
---

# Azure Platform Bootstrap

The Service Principal set up by this module does not have any subscription-level privileges.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.18.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.18.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.5.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_app_role_assignment.cloudfoundation_deploy-approle](https://registry.terraform.io/providers/hashicorp/azuread/2.18.0/docs/resources/app_role_assignment) | resource |
| [azuread_app_role_assignment.cloudfoundation_deploy-directory](https://registry.terraform.io/providers/hashicorp/azuread/2.18.0/docs/resources/app_role_assignment) | resource |
| [azuread_application.cloudfoundation_deploy](https://registry.terraform.io/providers/hashicorp/azuread/2.18.0/docs/resources/application) | resource |
| [azuread_service_principal.cloudfoundation_deploy](https://registry.terraform.io/providers/hashicorp/azuread/2.18.0/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.cloudfoundation_deploy](https://registry.terraform.io/providers/hashicorp/azuread/2.18.0/docs/resources/service_principal_password) | resource |
| [azurerm_role_assignment.cloudfoundation_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.cloudfoundation_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/role_definition) | resource |
| [local_file.output_md](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/2.18.0/docs/data-sources/application_published_app_ids) | data source |
| [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/2.18.0/docs/data-sources/service_principal) | data source |
| [azurerm_management_group.root](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/data-sources/management_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_tenant_id"></a> [aad\_tenant\_id](#input\_aad\_tenant\_id) | Id of the AAD Tenant. This is also the simultaneously the id of the root management group. | `string` | n/a | yes |
| <a name="input_output_md_file"></a> [output\_md\_file](#input\_output\_md\_file) | location of the file where this cloud foundation kit module generates its documentation output | `string` | n/a | yes |
| <a name="input_service_principal_name"></a> [service\_principal\_name](#input\_service\_principal\_name) | name of the Service Principal for deploying the cloud foundation | `string` | `"cloudfoundation_tf_deploy_user"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | n/a |
<!-- END_TF_DOCS -->