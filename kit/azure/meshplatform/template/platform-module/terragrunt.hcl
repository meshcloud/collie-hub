include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

dependency "bootstrap" {
  config_path = "../bootstrap"
}

dependency "organization_hierarchy" {
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
  subscription_id = "${include.platform.locals.platform.azure.subscriptionId}"
}
EOF
}

terraform {
  source = "${get_repo_root()}//kit/azure/meshplatform"
}

inputs = {
  replicator_custom_role_scope = dependency.bootstrap.outputs.parent_management_group
  metering_assignment_scopes   = [dependency.bootstrap.outputs.parent_management_group]
  replicator_assignment_scopes = [dependency.bootstrap.outputs.parent_management_group]
  can_cancel_subscriptions_in_scopes = [
    dependency.organization_hierarchy.outputs.landingzones_id
  ]
}
