include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

dependency "bootstrap" {
  config_path = "${path_relative_from_include()}/bootstrap"
}

terraform {
  source = "${get_repo_root()}//kit/azure/buildingblocks/spoke-vnet-configuration"
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
provider "azapi" {
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
  subscription_id = "${include.platform.locals.platform.azure.subscriptionId}"
  client_id       = "${dependency.bootstrap.outputs.client_id}"
  client_secret   = "${dependency.bootstrap.outputs.client_secret}"
}
EOF
}

inputs = {
  # todo: set input variables
  storage_account_resource_id = dependency.bootstrap.outputs.module_storage_account_resource_id

  #"The scope where this service principal have access on. Usually in the format of '/providers/Microsoft.Management/managementGroups/0000-0000-0000'"
  deployment_scope        = "/providers/Microsoft.Management/managementGroups/XXXXXXXX"
  backend_tf_config_path  = "${get_repo_root()}//kit/azure/buildingblocks/spoke-vnet-configuration/outputs/generated-backend.tf"
  provider_tf_config_path = "${get_repo_root()}//kit/azure/buildingblocks/spoke-vnet-configuration/outputs/generated-provider.tf"

  # Hub-related input variables:
  # Resource group name in which the hub vnet resides
  hub-vnet-rg = "hub-vnet-rg"
  # Hub virtual network name
  hub-vnet = "hub-vnet"
  # Name of the route table for the hub network
  hub-route-table = "hub-route-table"
}
