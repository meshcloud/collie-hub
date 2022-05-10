# Place your module's terraform resources, variables, outputs etc. here as usual.
# Note that you should typically not put a terraform{} block into cloud foundation kit modules,
# these will be provided by the platform implementations using this kit module.

variable "foundation_project_id" {
  type        = string
  description = "Project ID of the GCP Project hosting foundation-level resources for this foundation"
}

variable "service_account_name" {
  type        = string
  description = "name of the Service Account used to deploy cloud foundation resources"
  default     = "foundation-tf-deploy-user"
}

variable "service_account_credentials_file" {
  type        = string
  description = "location where to store the credentails file for the Service Account"

}

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

resource "local_file" "gcp_credentials_file" {
  filename        = var.service_account_credentials_file
  file_permission = "600" # only current user can read/write
  content         = base64decode(google_service_account_key.cloudfoundation_tf_deploy_user.private_key)
}

resource "google_project_service" "cloudresourcemanager_api" {
  project            = data.google_project.foundation.project_id
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_organization_iam_custom_role" "cloudfoundation_tf_deploy_user" {
  role_id     = "${replace(var.service_account_name, "-", "_")}_service"
  org_id      = data.google_project.foundation.org_id
  title       = "${var.service_account_name} service role"
  description = "Role for ${var.service_account_name} service account used for deploying the cloud foundation"
  permissions = [
    "resourcemanager.folders.get",
    "resourcemanager.folders.list",
    "resourcemanager.organizations.get",
    "resourcemanager.projects.create",
    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.list",
    "resourcemanager.projects.move",
    "resourcemanager.projects.setIamPolicy",
    "resourcemanager.projects.update",

    "serviceusage.services.enable",
    "serviceusage.services.get"
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

