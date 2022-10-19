---
name: GCP Billing Account Setup
summary: |
  deploys new cloud foundation infrastructure.
  Add a concise description of the module's purpose here.
# optional: add additional metadata about implemented security controls
---

# GCP Billing Account Setup

This documentation is intended as a reference documentation for cloud foundation or platform engineers using this module.
  
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_collie_billing_view"></a> [collie\_billing\_view](#module\_collie\_billing\_view) | ./modules/collie-billing-view | n/a |

## Resources

| Name | Type |
|------|------|
| [google_bigquery_table_iam_member.cloudfoundation_tf_deploy_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table_iam_member) | resource |
| [google_billing_account_iam_binding.billing_administrators](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_account_iam_binding) | resource |
| [google_project_iam_custom_role.cloudfoundation_tf_deploy_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.cloudfoundation_tf_deploy_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [local_file.output_md](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [google_billing_account.account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/billing_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | id of the billing account to manage. | `string` | n/a | yes |
| <a name="input_billing_users"></a> [billing\_users](#input\_billing\_users) | ids of users that require billing admin access. | `list(string)` | n/a | yes |
| <a name="input_cloud_billing_export_dataset_id"></a> [cloud\_billing\_export\_dataset\_id](#input\_cloud\_billing\_export\_dataset\_id) | Id of the BigQuery dataset holding the Cloud Billing export inside `cloud_billing_export_project`, without project prefix. | `string` | n/a | yes |
| <a name="input_cloud_billing_export_project"></a> [cloud\_billing\_export\_project](#input\_cloud\_billing\_export\_project) | Id of the GCP project holding the Cloud Billing export dataset. The export has to be set up manually since there's no terraform support for this. | `string` | n/a | yes |
| <a name="input_cloud_billing_export_table_id"></a> [cloud\_billing\_export\_table\_id](#input\_cloud\_billing\_export\_table\_id) | Name of the table holding the Cloud Billing export data inside the dataset identified by `cloud_billing_export_dataset_id`. | `string` | n/a | yes |
| <a name="input_enable_collie_view"></a> [enable\_collie\_view](#input\_enable\_collie\_view) | When enabled, will create a view called `collie_billing_view` to be used by collie cli for GCP cost reporting | `bool` | n/a | yes |
| <a name="input_output_md_file"></a> [output\_md\_file](#input\_output\_md\_file) | location of the file where this cloud foundation kit module generates its documentation output | `string` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | n/a | `string` | n/a | yes |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_collie_billing_view_ids"></a> [collie\_billing\_view\_ids](#output\_collie\_billing\_view\_ids) | n/a |
<!-- END_TF_DOCS -->