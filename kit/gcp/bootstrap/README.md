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

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

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
| [local_file.output_md](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [time_rotating.key_rotation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [google_project.foundation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_foundation_project_id"></a> [foundation\_project\_id](#input\_foundation\_project\_id) | Project ID of the GCP Project hosting foundation-level resources for this foundation | `string` | n/a | yes |
| <a name="input_output_md_file"></a> [output\_md\_file](#input\_output\_md\_file) | location of the file where this cloud foundation kit module generates its documentation output | `string` | n/a | yes |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | name of the Service Account used to deploy cloud foundation resources | `string` | `"foundation-tf-deploy-user"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_account_credentials"></a> [service\_account\_credentials](#output\_service\_account\_credentials) | base64 encoded service account credentials file content |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | n/a |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | n/a |
<!-- END_TF_DOCS -->