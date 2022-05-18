# note: this is a separate module so it's consumable independently of the kit modules we ship as part of 
# landing zone construction kit

resource "google_bigquery_table" "collie_billing_view" {
  deletion_protection = false
  project             = var.cloud_billing_export_project
  dataset_id          = var.cloud_billing_export_dataset_id
  table_id            = "collie_billing_view"

  view {
    query          = <<EOF
SELECT
  invoice.month as invoice_month,
  project.id as project_id,
  currency,
  (SUM(CAST(cost * 1000000 AS int64) / 1000000)) as cost
FROM `${var.cloud_billing_export_dataset_id}.${var.cloud_billing_export_table_id}`
GROUP BY 1, 2, 3;
EOF
    use_legacy_sql = false
  }
}
