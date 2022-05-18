variable "cloud_billing_export_project" {
  type        = string
  description = "Id of the GCP project holding the Cloud Billing export dataset. The export has to be set up manually since there's no terraform support for this."
}

variable "cloud_billing_export_dataset_id" {
  type        = string
  description = "Id of the BigQuery dataset holding the Cloud Billing export inside `cloud_billing_export_project`, without project prefix."
}

variable "cloud_billing_export_table_id" {
  type        = string
  description = "Name of the table holding the Cloud Billing export data inside the dataset identified by `cloud_billing_export_dataset_id`."
}
