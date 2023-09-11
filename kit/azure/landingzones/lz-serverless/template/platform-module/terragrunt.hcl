include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

include "module" {
  path = find_in_parent_folders("module.hcl")
}

terraform {
  source = "${get_repo_root()}//kit/azure/landingzones/lz-serverless"
}

#dependency "bootstrap" {
#  config_path = "../bootstrap"
#}

dependency "organization-hierarchy" {
  config_path = "../../organization-hierarchy"
}

inputs = {
  # todo: set input variables
  parent_management_group_id = "${dependency.organization-hierarchy.outputs.landingzones_id}"
  location                   = "${try(include.platform.locals.tfstateconfig.location, "could not read location from stateconfig. configure it explicitly")}"
}
