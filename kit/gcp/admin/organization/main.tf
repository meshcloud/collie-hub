# get a reference to the currently authenticated project - this is the foundation project
data "google_project" "foundation" {
}

locals {
  organization_id = data.google_project.foundation.org_id
}

data "google_organization" "orgs" {
  for_each = toset(var.domains_to_allow)
  domain   = each.value
}

locals {
  resolved_customer_ids_to_allow = concat(
    [for org in data.google_organization.orgs : {
      customer_id = org["directory_customer_id"],
      domain      = org.domain
      }
    ],
    var.customer_ids_to_allow
  )
}

module "allowed-policy-member-domains" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 5.1.0"
  policy_for        = "organization"
  organization_id   = local.organization_id
  constraint        = "constraints/iam.allowedPolicyMemberDomains"
  policy_type       = "list"
  allow             = local.resolved_customer_ids_to_allow[*].customer_id
  allow_list_length = length(local.resolved_customer_ids_to_allow)
}

module "allowed-policy-resource-locations" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 5.1.0"
  policy_for        = "organization"
  organization_id   = local.organization_id
  constraint        = "constraints/gcp.resourceLocations"
  policy_type       = "list"
  allow             = var.resource_locations_to_allow
  allow_list_length = length(var.resource_locations_to_allow)
}

