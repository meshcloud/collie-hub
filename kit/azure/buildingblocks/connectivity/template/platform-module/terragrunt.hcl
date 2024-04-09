include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

dependency "networking" {
  config_path = "../../networking"
}

dependency "corp_online" {
  config_path = "../../landingzones/corp-online"
}

dependency "automation" {
  config_path = "../automation"
}

# deploy to the hub subscription
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azurerm" {
  features {}
  skip_provider_registration = true
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
  subscription_id = "${dependency.networking.outputs.hub_subscription}"
  storage_use_azuread = true
}
EOF
}

terraform {
  source = "${get_repo_root()}//kit/azure/buildingblocks/connectivity"
}

inputs = {
  name  = "connectivity"
  scope = dependency.corp_online.outputs.corp_id

  principal_ids = toset([
    dependency.networking.outputs.network_admins_azuread_group_id,
    dependency.automation.outputs.principal_id
  ])
}
