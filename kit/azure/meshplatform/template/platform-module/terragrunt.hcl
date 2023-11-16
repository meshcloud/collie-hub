include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

terraform {
  source = "${get_repo_root()}//kit/azure/meshplatform"
}

dependency "bootstrap" {
  config_path = "${path_relative_from_include()}/bootstrap"
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
  client_id       = "${dependency.bootstrap.outputs.client_id}"
  client_secret   = "${dependency.bootstrap.outputs.client_secret}"
  }
EOF
}

inputs = {
  # todo: set input variables
  service_principal_name_suffix = "${include.platform.locals.cloudfoundation.name}.meshcloud.io"
  mgmt_group_name               = "${include.platform.locals.platform.azure.aadTenantId}"
  subscriptions                 = []
}
