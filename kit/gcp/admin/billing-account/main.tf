data "google_billing_account" "account" {
  billing_account = var.billing_account_id
  open            = true
}

resource "google_billing_account_iam_binding" "billing_administrators" {
  billing_account_id = var.billing_account_id
  role               = "roles/billing.admin"
  members            = [for u in var.billing_users : "user:${u}"]
}

# we can't set up the billing export with terraform, this has to be done manually
# see https://github.com/hashicorp/terraform-provider-google/issues/4848

# todo: do we want to include the setup of the GCP project hosting the export dataset as a kit module as well?


# give our deploy user sufficient permissions to create the required big query view
resource "google_project_iam_custom_role" "cloudfoundation_tf_deploy_user" {
  role_id     = "${replace(var.service_account_name, "-", "_")}_service"
  project     = var.cloud_billing_export_project
  title       = "${var.service_account_name} service role"
  description = "Role for ${var.service_account_name} service account used for deploying the cloud foundation"
  permissions = [
    "bigquery.tables.create",
    "bigquery.tables.delete",
    "bigquery.tables.get",
    "bigquery.tables.getIamPolicy",
    "bigquery.tables.setIamPolicy",
    "bigquery.config.get",
  ]
}

# assign the custom role to the deploy user
resource "google_project_iam_member" "cloudfoundation_tf_deploy_user" {
  project = var.cloud_billing_export_project
  role    = google_project_iam_custom_role.cloudfoundation_tf_deploy_user.id
  member  = "serviceAccount:${var.service_account_email}"
}

# the deploy user needs permission to query the underlying billing export data in order to be allowed to create a VIEW on it
resource "google_bigquery_table_iam_member" "cloudfoundation_tf_deploy_user" {
  depends_on = [
    google_project_iam_member.cloudfoundation_tf_deploy_user
  ]
  project    = var.cloud_billing_export_project
  dataset_id = var.cloud_billing_export_dataset_id
  table_id   = var.cloud_billing_export_table_id
  role       = "roles/bigquery.dataViewer"
  member     = "serviceAccount:${var.service_account_email}"
}

module "collie_billing_view" {
  depends_on = [
    google_bigquery_table_iam_member.cloudfoundation_tf_deploy_user # ensure permissions were set up before creating the view
  ]
  count  = var.enable_collie_view ? 1 : 0
  source = "./modules/collie-billing-view"

  cloud_billing_export_project    = var.cloud_billing_export_project
  cloud_billing_export_dataset_id = var.cloud_billing_export_dataset_id
  cloud_billing_export_table_id   = var.cloud_billing_export_table_id
}

