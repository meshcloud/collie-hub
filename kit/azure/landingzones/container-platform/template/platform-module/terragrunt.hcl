include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

dependency "bootstrap" {
  config_path = "${path_relative_from_include()}/bootstrap"
}

dependency "organization-hierarchy" {
  config_path = "${path_relative_from_include()}/organization-hierarchy"
}

terraform {
  source = "${get_repo_root()}//kit/azure/landingzones/container-platform"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azurerm" {
  features {}
  skip_provider_registration = true
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
  subscription_id = "${include.platform.locals.platform.azure.subscriptionId}"
  }
EOF
}

inputs = {
  # todo: set input variables
  parent_management_group_id = "${dependency.organization-hierarchy.outputs.landingzones_id}"
  location                   = "${try(include.platform.locals.tfstateconfig.location, "could not read location from stateconfig. configure it explicitly")}"
}
