include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

dependency "bootstrap" {
  config_path = "${path_relative_from_include()}/bootstrap"
}

terraform {
  source = "${get_repo_root()}//kit/azure/organization-hierarchy"
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

locals {
  # the prefix used the name of your cloudfoundation
  management_group_prefix = "${include.platform.locals.cloudfoundation.name}"
}

inputs = {
  # todo: set input variables
  connectivity          = "${local.management_group_prefix}-connectivity"
  identity              = "${local.management_group_prefix}-identity"
  landingzones          = "${local.management_group_prefix}-landingzones"
  locations             = ["germanywestcentral"]
  management            = "${local.management_group_prefix}-management"
  parentManagementGroup = "${local.management_group_prefix}-foundation"
  platform              = "${local.management_group_prefix}-platform"
}
