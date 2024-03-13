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

## Documentation on Github-Pages

We offer the option of fully automated creation of a cloud infrastructure and generation of the corresponding documentation.
An example of this is integration with Github Pages [likvid-foundation Documentation](https://likvid-bank.github.io/likvid-cloudfoundation/).
To automatically generate the documentation via a pipeline, we use a `Service Principal` with `Federated Identity Credentials` that have read access
to the storage container where the states of the individual kits are stored. This read access allows for the automated rollout of a page when
there are changes to the infrastructure, using a [Github Actions Workflow](https://github.com/likvid-bank/likvid-cloudfoundation/blob/main/.github/workflows/docs.yml).

for enabling the read only servcice principal add following values to your terragrunt.hcl:

```hcl
# Example with likvid Bank
inputs = {
  ...
  uami_documentation_spn     = true
  uami_documentation_subject = "repo:likvid/likvid-foundation:environment:github-pages"
  uami_documentation_name    = "likvid-foundation_tf_docs_user"
  ...
}
```

:::tip
You don't know how to integrate the documentation into collie? Take a look at our [Tutorial](https://collie.cloudfoundation.org/tutorial/#generate-documentation)!
:::

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
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.46.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.81.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform_state"></a> [terraform\_state](#module\_terraform\_state) | ./terraform-state | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_group.platform_engineers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azurerm_role_assignment.cloudfoundation_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.tfstates_engineers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.cloudfoundation_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application_published_app_ids) | data source |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azuread_users.platform_engineers_members](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |
| [azurerm_management_group.root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_tenant_id"></a> [aad\_tenant\_id](#input\_aad\_tenant\_id) | Id of the AAD Tenant. This is also the simultaneously the id of the root management group. | `string` | n/a | yes |
| <a name="input_platform_engineers_group"></a> [platform\_engineers\_group](#input\_platform\_engineers\_group) | the name of the cloud foundation platform engineers group | `string` | `"cloudfoundation-platform-engineers"` | no |
| <a name="input_platform_engineers_members"></a> [platform\_engineers\_members](#input\_platform\_engineers\_members) | Set up a group of platform engineers. If enabled, this group will receive access to terraform\_state\_storage | <pre>list(object({<br>    email = string,<br>    upn   = string,<br>  }))</pre> | n/a | yes |
| <a name="input_terraform_state_storage"></a> [terraform\_state\_storage](#input\_terraform\_state\_storage) | Configure this object to enable setting up a terraform state store in Azure Storage. | <pre>object({<br>    location         = string,<br>    name             = string,<br>    config_file_path = string<br>  })</pre> | `null` | no |
| <a name="input_uami_documentation_issuer"></a> [uami\_documentation\_issuer](#input\_uami\_documentation\_issuer) | Specifies the subject for this Federated Identity Credential, for example a github action pipeline | `string` | `"https://token.actions.githubusercontent.com"` | no |
| <a name="input_uami_documentation_name"></a> [uami\_documentation\_name](#input\_uami\_documentation\_name) | name of the Service Principal used to perform documentation and validation tasks | `string` | `"cloudfoundation_tf_docs_user"` | no |
| <a name="input_uami_documentation_spn"></a> [uami\_documentation\_spn](#input\_uami\_documentation\_spn) | read-only user for the states to host the documentation or activate a drift detection pipeline | `bool` | `false` | no |
| <a name="input_uami_documentation_subject"></a> [uami\_documentation\_subject](#input\_uami\_documentation\_subject) | Specifies the subject for this Federated Identity Credential, for example a github action pipeline | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_module_storage_account_resource_id"></a> [module\_storage\_account\_resource\_id](#output\_module\_storage\_account\_resource\_id) | n/a |
| <a name="output_platform_engineers_azuread_group_displayname"></a> [platform\_engineers\_azuread\_group\_displayname](#output\_platform\_engineers\_azuread\_group\_displayname) | n/a |
| <a name="output_platform_engineers_azuread_group_id"></a> [platform\_engineers\_azuread\_group\_id](#output\_platform\_engineers\_azuread\_group\_id) | n/a |
| <a name="output_platform_engineers_members"></a> [platform\_engineers\_members](#output\_platform\_engineers\_members) | n/a |
<!-- END_TF_DOCS -->
