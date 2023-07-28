include "platform" {
  path = find_in_parent_folders("platform.hcl")
  expose = true
}

include "module" {
  path = find_in_parent_folders("module.hcl")
}

terraform {
  source = "${get_repo_root()}//kit/azure/activity-log"
}

dependency "bootstrap" {
  config_path = "../bootstrap"
  }

dependency "organization-hierarchy" {
  config_path = "../organization-hierarchy"
}

inputs = {
  # todo: set input variables
  admin_management_group_id           = "${dependency.organization-hierarchy.outputs.platform_id}"
  cloudfoundation_deploy_principal_id = "${dependency.bootstrap.outputs.client_id}"
  log_retention_in_days               = 30
  platform_management_group_id        = "${dependency.organization-hierarchy.outputs.management_id}"
  subscription_id                     = "${include.platform.locals.platform.azure.subscriptionId}"
  
}
