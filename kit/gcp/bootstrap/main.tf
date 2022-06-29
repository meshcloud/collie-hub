# Place your module's terraform resources, variables, outputs etc. here as usual.
# Note that you should typically not put a terraform{} block into cloud foundation kit modules,
# these will be provided by the platform implementations using this kit module.

data "google_project" "foundation" {
  project_id = var.foundation_project_id
}

resource "google_service_account" "cloudfoundation_tf_deploy_user" {
  project      = data.google_project.foundation.project_id
  account_id   = var.service_account_name
  display_name = var.service_account_name
}

# note this requires the terraform to be run regularly
resource "time_rotating" "key_rotation" {
  rotation_days = 365
}

resource "google_service_account_key" "cloudfoundation_tf_deploy_user" {
  service_account_id = google_service_account.cloudfoundation_tf_deploy_user.name
  keepers = {
    rotation_time = time_rotating.key_rotation.rotation_rfc3339
  }
}

locals {
  # the foundation service account needs to deploy resources of various kinds
  # because it authenticates against the foundation project, we do unfortunately ahve
  # to list and enable all of these services here
  enabled_services = toset([
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "bigquery.googleapis.com",
    "bigquerydatatransfer.googleapis.com"
  ])
}

resource "google_project_service" "enabled_services" {
  project            = data.google_project.foundation.project_id
  for_each           = local.enabled_services
  service            = each.key
  disable_on_destroy = false
}

resource "google_organization_iam_custom_role" "cloudfoundation_tf_deploy_user" {
  role_id     = "${replace(var.service_account_name, "-", "_")}_service"
  org_id      = data.google_project.foundation.org_id
  title       = "${var.service_account_name} service role"
  description = "Role for ${var.service_account_name} service account used for deploying the cloud foundation"
  permissions = [
    "resourcemanager.organizations.get",

    "resourcemanager.folders.get",
    "resourcemanager.folders.list",
    "resourcemanager.folders.create",
    "resourcemanager.folders.delete",
    "resourcemanager.folders.update",
    "resourcemanager.folders.move",

    "resourcemanager.folders.getIamPolicy",
    "resourcemanager.folders.setIamPolicy",

    "resourcemanager.projects.create",
    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.list",
    "resourcemanager.projects.move",
    "resourcemanager.projects.setIamPolicy",
    "resourcemanager.projects.update",

    "iam.roles.create",
    "iam.roles.delete",
    "iam.roles.get",
    "iam.roles.list",
    "iam.roles.undelete",
    "iam.roles.update",

    "iam.serviceAccounts.get",

    "serviceusage.services.enable",
    "serviceusage.services.get",
    "serviceusage.services.list",

    "billing.accounts.get",
    "billing.accounts.list",
    "billing.accounts.getIamPolicy",
    "billing.accounts.setIamPolicy",
    "billing.accounts.getUsageExportSpec",
    "billing.accounts.updateUsageExportSpec",
    "billing.resourceAssociations.list"
  ]
}

resource "google_organization_iam_member" "cloudfoundation_tf_deploy_user" {
  org_id = data.google_project.foundation.org_id
  role   = google_organization_iam_custom_role.cloudfoundation_tf_deploy_user.id
  member = "serviceAccount:${google_service_account.cloudfoundation_tf_deploy_user.email}"
}

# relevant permissions in the policyAdmin role are only available via the built-in role and cannot be assigned to custom
# roles, so we have to use the built-in one here
resource "google_organization_iam_member" "cloudfoundation_tf_deploy_user_org_policy_admin" {
  org_id = data.google_project.foundation.org_id
  role   = "roles/orgpolicy.policyAdmin"
  member = "serviceAccount:${google_service_account.cloudfoundation_tf_deploy_user.email}"
}

