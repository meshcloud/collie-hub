# github-repo-building-block

Module that creates a github.com repository. This repository can be based on a template repo.
It can be used as a Building Block inside of meshStack.

https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository

## How to use this Building Block in meshStack

1. Go to your meshStack admin area and click on "Building Blocks" from the left pane
2. Click on "Create Building Block"
3. Fill out the general information and click next
4. Select any of the platforms as your supported platform to attach this building block to.
5. Select "Terraform" in Implementation Type and put in the Terraform version
6. Copy the repository HTTPS address to the "Git Repository URL" field (if its a private repo, add your SSH key) click next
7. For the inputs do the following
    - Backend configuration:
        - Select "File" as input type and upload the backend.tf file.
        - Add related environment variables based on your backend configuration (e.g. client_id and client_secret for azure, SA_ID and SA_EMAIL for GCS)
    - add other Variables:
        - github_token and github_owner variable is the required credentials for the github provider
    - add rest of the variables in variables.tf as you desired
8. On the next page, add the outputs from outputs.tf file and click on Create Building Block
9. Now users can add this building block to their tenants

### Env vars needed for provider

https://registry.terraform.io/providers/integrations/github/latest/docs

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | 5.34.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/5.34.0/docs/resources/repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `"created by github-repo-building-block"` | no |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | n/a | `string` | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | n/a | `string` | n/a | yes |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | n/a | `string` | n/a | yes |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | n/a | `string` | `"private"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repo_full_name"></a> [repo\_full\_name](#output\_repo\_full\_name) | n/a |
| <a name="output_repo_git_clone_url"></a> [repo\_git\_clone\_url](#output\_repo\_git\_clone\_url) | n/a |
| <a name="output_repo_html_url"></a> [repo\_html\_url](#output\_repo\_html\_url) | n/a |
| <a name="output_repo_name"></a> [repo\_name](#output\_repo\_name) | n/a |
<!-- END_TF_DOCS -->