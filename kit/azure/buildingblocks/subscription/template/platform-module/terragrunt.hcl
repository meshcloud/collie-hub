include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

dependency "bootstrap" {
  config_path = "../../bootstrap"
}

dependency "organization-hierarchy" {
  config_path = "../../organization-hierarchy"
}

# we deploy to the management subscription here, as the subscription building block is central to all LZs
# we also deploy the backplane like all other platform modules with azure-cli auth
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azurerm" {
  features {}
  skip_provider_registration = true
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
  subscription_id = "${include.platform.locals.platform.azure.subscriptionId}"
  storage_use_azuread = true
}
EOF
}

terraform {
  source = "${get_repo_root()}//kit/azure/buildingblocks/subscription"
}

inputs = {
  name          = "subscription"
  principal_ids = toset([dependency.bootstrap.outputs.platform_engineers_azuread_group_id])
  scope         = dependency.organization-hierarchy.outputs.landingzones_id
}
