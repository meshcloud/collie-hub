include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

terraform {
  source = "${get_repo_root()}//kit/azure/logging"
}

dependency "bootstrap" {
  config_path = "../bootstrap"
}

dependency "organization-hierarchy" {
  config_path = "../organization-hierarchy"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azurerm" {
  features {}
  skip_provider_registration = true
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"

  # recommended: use a separate subscription to archive logs
  subscription_id = "the-id-of-your-logging-subscription"
}

provider "azuread" {
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
}

provider "azapi" {
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
  subscription_id = "the-id-of-your-logging-subscription"
}
EOF
}

inputs = {
  # todo: set input variables
  parent_management_group_id = "${dependency.organization-hierarchy.outputs.management_id}"
  scope                      = "${dependency.organization-hierarchy.outputs.parent_id}"
  cloudfoundation            = "${include.platform.locals.cloudfoundation.name}"
  location                   = "germanywestcentral"
  log_retention_in_days      = 30
}
