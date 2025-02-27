# Terraform OVH Project

This Terraform project is used to manage resources in the Stackit cloud platform. It provisions projects, manages users, and configures necessary providers.

## Prerequisites

- Terraform v1.0.0 or later
- AWS credentials configured for the backend
- Stackit service account token

## Providers

This project uses the following providers:

- `stackit`: Manages resources in the Stackit cloud platform.
- `aws`: Manages resources in AWS.
- `null`: Provides null resources for triggering local-exec provisioners.

## Usage

1. Clone the repository.
2. Initialize Terraform:
   ```sh
   terraform init
   ```
3. Apply the Terraform configuration:
   ```sh
   terraform apply
   ```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.65.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |
| <a name="requirement_stackit"></a> [stackit](#requirement\_stackit) | 0.37.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.create_user](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [null_resource.project_admin](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [null_resource.project_editor](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [null_resource.project_reader](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [stackit_resourcemanager_project.projects](https://registry.terraform.io/providers/stackitcloud/stackit/0.37.1/docs/resources/resourcemanager_project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | Base API URL | `string` | `"https://authorization.api.stackit.cloud"` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | this is for the tfstates Backend. in our case AWS. | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | id of the organization | `string` | n/a | yes |
| <a name="input_parent_container_id"></a> [parent\_container\_id](#input\_parent\_container\_id) | The stackit Cloud parent container id for the project | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Projects last block in name | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | Bearer token for authentication | `string` | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | Users and their roles provided by meshStack (Note that users must exist in stackit) | <pre>list(object(<br>    {<br>      meshIdentifier = string<br>      username       = string<br>      firstName      = string<br>      lastName       = string<br>      email          = string<br>      euid           = string<br>      roles          = list(string)<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | Projects first block in name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_stackit_login_link"></a> [stackit\_login\_link](#output\_stackit\_login\_link) | n/a |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | n/a |
<!-- END_TF_DOCS -->
