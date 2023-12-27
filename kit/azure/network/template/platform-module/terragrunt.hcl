include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

terraform {
  source = "${get_repo_root()}//kit/azure/network"
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
  client_id       = "${dependency.bootstrap.outputs.client_id}"
  client_secret   = "${dependency.bootstrap.outputs.client_secret}"
}

provider "azuread" {
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
  client_id       = "${dependency.bootstrap.outputs.client_id}"
  client_secret   = "${dependency.bootstrap.outputs.client_secret}"
}
EOF
}

inputs = {
  # todo: set input variables
  parent_management_group_id          = "${dependency.organization-hierarchy.outputs.management_id}"
  scope                               = "${dependency.organization-hierarchy.outputs.parent_id}"
  location                            = "germanywestcentral"
}
