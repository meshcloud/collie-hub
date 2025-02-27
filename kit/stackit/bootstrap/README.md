# STACKIT Cloud Custom Platform

## Overview
This Terraform project enables seamless self-service provisioning and management of STACKIT Projects for development teams. The platform is based on the STACKIT Cloud and is designed to provide a secure and compliant environment for development teams to deploy and manage their applications.

## Documentation
For more information, check our [Guide for STACKIT](/likvid-cloudfoundation/meshstack/guides/guide_stackit.html).

## Usage
1. Initialize the Terraform configuration:
   ```sh
   terraform init
   ```
2. Apply the Terraform configuration:
   ```sh
   terraform apply
   ```

## Requirements
- Terraform 0.12 or later
- STACKIT Cloud account

## Providers
- `stackitcloud/stackit` version `0.37.1`
- `hashicorp/null` version `3.2.2`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |
| <a name="requirement_stackit"></a> [stackit](#requirement\_stackit) | 0.37.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.platform_admin](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [null_resource.platform_users](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | Base API URL | `string` | `"https://authorization.api.stackit.cloud"` | no |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | Organization ID of your stackit cloud account | `string` | n/a | yes |
| <a name="input_platform_admins"></a> [platform\_admins](#input\_platform\_admins) | List of members to add with their roles and subjects | <pre>list(object({<br>    role    = string<br>    subject = string<br>  }))</pre> | n/a | yes |
| <a name="input_platform_users"></a> [platform\_users](#input\_platform\_users) | List of members to add with their roles and subjects | <pre>list(object({<br>    role    = string<br>    subject = string<br>  }))</pre> | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | Bearer token for authentication | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->