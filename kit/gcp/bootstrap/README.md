---
name: GCP Platform Bootstrap
summary: |
  creates a service account with permissions to deploy the cloud foundation infrastructure.
  This is a "bootstrap" module, which means that it must be manually executed once by an administrator
  to bootstrap the cloudfoundation
---

# GCP Platform Bootstrap

Service Accounts in GCP must be created in a project. This module assumes that an operator manually creates this project
and supplies it as to the module's input `foundation_project_id`.
  
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.80.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_organization_iam_custom_role.cloudfoundation_tf_deploy_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_member.cloudfoundation_tf_deploy_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.cloudfoundation_tf_deploy_user_org_policy_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_project_service.enabled_services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.cloudfoundation_tf_deploy_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.cloudfoundation_tf_deploy_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [time_rotating.key_rotation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [google_project.foundation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_foundation_project_id"></a> [foundation\_project\_id](#input\_foundation\_project\_id) | Project ID of the GCP Project hosting foundation-level resources for this foundation | `string` | n/a | yes |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | name of the Service Account used to deploy cloud foundation resources | `string` | `"foundation-tf-deploy-user"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_service_account_credentials"></a> [service\_account\_credentials](#output\_service\_account\_credentials) | base64 encoded service account credentials file content |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | n/a |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | n/a |
<!-- END_TF_DOCS -->