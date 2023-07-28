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
  admin_management_group_id           = "${dependency.organization-hierarchy.outputs.parent_id}"
  cloudfoundation_deploy_principal_id = "${dependency.bootstrap.outputs.client_principal_id}"
  platform_management_group_id        = "${dependency.organization-hierarchy.outputs.platform_id}"
  subscription_id                     = "${include.platform.locals.platform.azure.subscriptionId}"
  resources_cloudfoundation           = "${dependency.bootstrap.outputs.resources_cloudfoundation}"
  location                            = "${try(include.platform.locals.tfstateconfig.location, "")}"
  log_retention_in_days               = 30
}
