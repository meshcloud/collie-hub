---
name: Azure Building Block - GitHub Repository
summary: |
  Building block module for creating a GitHub repository.
---

# Azure GitHub Repository

This documentation is intended as a reference for cloud foundation or platform engineers using this module.

## Permissions

This building block requires a service principal with permissions to manage GitHub repositories. The service principal should have a GitHub App installed with the necessary permissions to create repositories.

The private key of the GitHub App should be stored in Azure Key Vault and the service principal should have permissions to read this secret.

The service principal also needs permissions to assign the "Key Vault Reader" role to itself for the Key Vault where the GitHub App's private key is stored.

## Usage

This building block creates a GitHub repository with the specified name, description, and visibility. It also supports creating a repository based on a template repository.

You can specify the name of the GitHub organization, the name of the repository, whether to create a new repository or use a template, the owner and name of the template repository, and the visibility of the repository.

The GitHub token is retrieved from Azure Key Vault and used to authenticate with the GitHub API.

The building block outputs the name, description, and visibility of the created repository.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.81.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 5.34.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/5.34.0/docs/resources/repository) | resource |
| [azurerm_key_vault.cloudfoundation_keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.github_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_new"></a> [create\_new](#input\_create\_new) | Flag to indicate whether to create a new repository | `bool` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description of the GitHub repository | `string` | `"created by github-repo-building-block"` | no |
| <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id) | ID of the GitHub App | `string` | n/a | yes |
| <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id) | Installation ID of the GitHub App | `string` | n/a | yes |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | Name of the GitHub organization | `string` | n/a | yes |
| <a name="input_github_token_secret_name"></a> [github\_token\_secret\_name](#input\_github\_token\_secret\_name) | Name of the secret in Key Vault that holds the GitHub token | `string` | n/a | yes |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Name of the Key Vault | `string` | n/a | yes |
| <a name="input_key_vault_rg"></a> [key\_vault\_rg](#input\_key\_vault\_rg) | Name of the Resource Group where the Key Vault is located | `string` | n/a | yes |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | Name of the GitHub repository | `string` | `"github-repo"` | no |
| <a name="input_template_owner"></a> [template\_owner](#input\_template\_owner) | Owner of the template repository | `string` | `"template-owner"` | no |
| <a name="input_template_repo"></a> [template\_repo](#input\_template\_repo) | Name of the template repository | `string` | `"github-repo"` | no |
| <a name="input_use_template"></a> [use\_template](#input\_use\_template) | Flag to indicate whether to create a repo based on a Template Repository | `bool` | `false` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Visibility of the GitHub repository | `string` | `"private"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repo_full_name"></a> [repo\_full\_name](#output\_repo\_full\_name) | n/a |
| <a name="output_repo_git_clone_url"></a> [repo\_git\_clone\_url](#output\_repo\_git\_clone\_url) | n/a |
| <a name="output_repo_html_url"></a> [repo\_html\_url](#output\_repo\_html\_url) | n/a |
| <a name="output_repo_name"></a> [repo\_name](#output\_repo\_name) | n/a |
<!-- END_TF_DOCS -->
