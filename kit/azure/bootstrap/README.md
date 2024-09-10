---
name: Azure Bootstrap
summary: |
  creates a service principal with permissions to deploy the cloud foundation infrastructure.
  This is a "bootstrap" module, which means that it must be manually executed once by an administrator
  to bootstrap the cloudfoundation.
cfmm:
  - block: iam/privileged-access-management
    description: |
      creates a service principal with permissions to deploy the cloud foundation infrastructure and secure access
      to that service principal's credentials with an AAD group. This AAD group is used to grant platform engineers
      permission to deploy the cloud foundation infrastructure.
---

# Azure Bootstrap

This documentation is intended as a reference documentation for cloud foundation or platform engineers using this module.

## Terraform State Storage

This module includes configuration to set up a state backend using Azure blob storage.
You can activate this by configuring the `terraform_state_storage` variable.

Like all bootstrap modules published on collie hub, you will need to deploy this module twice to complete the bootstrap process.
To migrate the state, it may be necessary to logout once from the Azure CLI `az logout` and then login again `az login` to obtain the newly created permissions for the storage container.
Please see the [bootstrap tutorial](https://collie.cloudfoundation.org/tutorial/deploy-first-module.html#bootstrap-a-cloud-platform) for more info.

> If you're not using `terraform_state_storage`, please configure your own backend in `platform.hcl`

## Platform Engineers Group

This module sets up an AAD group for managing platform engineers. This is required in conjunction with
enabling access to terraform state storage but can also be used to grant administrative access to Azure resources.

### UPN handling for AAD Guest users

Useful if you need to translate emails into UPNs (User Principal Names) as necessary, especially for guest users.
You can add this code block to your terragrunt.hcl file instead of using inputs."

```hcl
locals {
upn_domain = "#EXT#@devmeshithesheep.onmicrosoft.com"
  platform_engineers_emails = [
    "meshi@meshithesheep.io" # #TODO change, enter PLATFORM ENGINEERS here
  ]

# change the upn_domain value above
  platform_engineers_members = [
    for x in local.platform_engineers_emails : {
      email = x
      upn   = "${replace(x, "@", "_")}${local.upn_domain}"
    }
  ]
}
```

## Remove Bootstrap (Unbootstraping)

The following sequence must be followed in order to remove the boostrap

>Delete the tfstates-config file. The platform.hcl is using the local backend
```bash
rm foundations/<foundationname>/platforms/<platformname>/tfstates-config.yml
```
>Migrate the state from the Storage account back to your local machine
```bash
collie foundation deploy --bootstrap -- init -migrate-state
```
>Destroy the bootsrap
```bash
collie foundation deploy --bootstrap -- destroy
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.53.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.116.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform_state"></a> [terraform\_state](#module\_terraform\_state) | ./terraform-state | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_directory_role.readers](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/directory_role) | resource |
| [azuread_directory_role_assignment.validation_reader](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/directory_role_assignment) | resource |
| [azuread_group.platform_engineers](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/resources/group) | resource |
| [azurerm_federated_identity_credential.docs](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/federated_identity_credential) | resource |
| [azurerm_federated_identity_credential.validation](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/federated_identity_credential) | resource |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/key_vault) | resource |
| [azurerm_resource_group.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.cloudfoundation_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cloudfoundation_tfdeploy](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.docs_tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.tfstates_engineers](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.validation_reader](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.validation_reader_keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.validation_tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.cloudfoundation_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_definition) | resource |
| [azurerm_role_definition.validation_reader](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_definition) | resource |
| [azurerm_user_assigned_identity.docs](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.validation](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/user_assigned_identity) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/data-sources/client_config) | data source |
| [azuread_users.platform_engineers_members](https://registry.terraform.io/providers/hashicorp/azuread/2.53.1/docs/data-sources/users) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/client_config) | data source |
| [azurerm_management_group.parent](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/management_group) | data source |
| [azurerm_role_definition.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_documentation_uami"></a> [documentation\_uami](#input\_documentation\_uami) | read-only UAMI with access to terraform states to generate documentation in CI pipelines | <pre>object({<br>    name = string<br>    # note: it seems wildcards are not supported yet, see https://github.com/Azure/azure-workload-identity/issues/373<br>    oidc_subject = string<br>  })</pre> | `null` | no |
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | This object contains configuration details for setting up a key vault. | <pre>object({<br>    name                = string,<br>    resource_group_name = string<br>  })</pre> | <pre>{<br>  "name": "cloudfoundation-kv",<br>  "resource_group_name": "cloudfoundation-rg"<br>}</pre> | no |
| <a name="input_parent_management_group_name"></a> [parent\_management\_group\_name](#input\_parent\_management\_group\_name) | Name of the management group you want to use as parent for your foundation. | `string` | n/a | yes |
| <a name="input_platform_engineers_group"></a> [platform\_engineers\_group](#input\_platform\_engineers\_group) | the name of the cloud foundation platform engineers group | `string` | n/a | yes |
| <a name="input_platform_engineers_members"></a> [platform\_engineers\_members](#input\_platform\_engineers\_members) | Set up a group of platform engineers. If enabled, this group will receive access to terraform\_state\_storage | <pre>list(object({<br>    email = string,<br>    upn   = string,<br>  }))</pre> | n/a | yes |
| <a name="input_terraform_state_storage"></a> [terraform\_state\_storage](#input\_terraform\_state\_storage) | Configure this object to enable setting up a terraform state store in Azure Storage. | <pre>object({<br>    location            = string,<br>    name                = string,<br>    config_file_path    = string,<br>    resource_group_name = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_validation_uami"></a> [validation\_uami](#input\_validation\_uami) | read-only UAMI with access to terraform states and read-only access on the landingzone architecture for validation of the deployment in CI pipelines | <pre>object({<br>    name = string<br>    # note: it seems wildcards are not supported yet, see https://github.com/Azure/azure-workload-identity/issues/373<br>    oidc_subject = string<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_key_vault"></a> [azurerm\_key\_vault](#output\_azurerm\_key\_vault) | n/a |
| <a name="output_azurerm_key_vault_rg_name"></a> [azurerm\_key\_vault\_rg\_name](#output\_azurerm\_key\_vault\_rg\_name) | n/a |
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_documentation_uami_client_id"></a> [documentation\_uami\_client\_id](#output\_documentation\_uami\_client\_id) | n/a |
| <a name="output_module_storage_account_resource_id"></a> [module\_storage\_account\_resource\_id](#output\_module\_storage\_account\_resource\_id) | n/a |
| <a name="output_parent_management_group"></a> [parent\_management\_group](#output\_parent\_management\_group) | n/a |
| <a name="output_platform_engineers_azuread_group_displayname"></a> [platform\_engineers\_azuread\_group\_displayname](#output\_platform\_engineers\_azuread\_group\_displayname) | n/a |
| <a name="output_platform_engineers_azuread_group_id"></a> [platform\_engineers\_azuread\_group\_id](#output\_platform\_engineers\_azuread\_group\_id) | n/a |
| <a name="output_platform_engineers_members"></a> [platform\_engineers\_members](#output\_platform\_engineers\_members) | n/a |
| <a name="output_validation_uami_client_id"></a> [validation\_uami\_client\_id](#output\_validation\_uami\_client\_id) | n/a |
<!-- END_TF_DOCS -->
