<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_table.collie_billing_view](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_billing_export_dataset_id"></a> [cloud\_billing\_export\_dataset\_id](#input\_cloud\_billing\_export\_dataset\_id) | Id of the BigQuery dataset holding the Cloud Billing export inside `cloud_billing_export_project`, without project prefix. | `string` | n/a | yes |
| <a name="input_cloud_billing_export_project"></a> [cloud\_billing\_export\_project](#input\_cloud\_billing\_export\_project) | Id of the GCP project holding the Cloud Billing export dataset. The export has to be set up manually since there's no terraform support for this. | `string` | n/a | yes |
| <a name="input_cloud_billing_export_table_id"></a> [cloud\_billing\_export\_table\_id](#input\_cloud\_billing\_export\_table\_id) | Name of the table holding the Cloud Billing export data inside the dataset identified by `cloud_billing_export_dataset_id`. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_view_id"></a> [view\_id](#output\_view\_id) | n/a |
<!-- END_TF_DOCS -->