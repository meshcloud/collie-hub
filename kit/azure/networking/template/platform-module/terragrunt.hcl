include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

terraform {
  source = "${get_repo_root()}//kit/azure/networking"
}

dependency "bootstrap" {
  config_path = "../bootstrap"
}

dependency "organization-hierarchy" {
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
  client_id       = "${dependency.bootstrap.outputs.client_id}"
  client_secret   = "${dependency.bootstrap.outputs.client_secret}"

  # recommended: use a separate subscription for networking
  subscription_id = "the-id-of-your-networking-subscription"
}

provider "azuread" {
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
  client_id       = "${dependency.bootstrap.outputs.client_id}"
  client_secret   = "${dependency.bootstrap.outputs.client_secret}"
}
EOF
}

inputs = {
  # todo: set input variables
  scope                               = "${dependency.organization-hierarchy.outputs.landingzones_id}"
  scope_network_admin                 = "${dependency.organization-hierarchy.outputs.parent_id}"
  cloudfoundation                     = "${include.platform.locals.cloudfoundation.name}"
  cloudfoundation_deploy_principal_id = "${dependency.bootstrap.outputs.client_principal_id}"
  parent_management_group_id          = "${dependency.organization-hierarchy.outputs.connectivity_id}"
  address_space                       = "10.0.0.0/16"
  location                            = "germanywestcentral"
  diagnostics = {
    destination = "${dependency.logging.outputs.law_workspace_id}"
    logs        = ["all"]
    metrics     = ["all"]
  }
  netwatcher = {
    resource_group_location          = "germanywestcentral"
    log_analytics_workspace_id       = "${dependency.logging.outputs.law_workspace_id}"
    log_analytics_workspace_id_short = "${dependency.logging.outputs.law_workspace_id_short}"
    log_analytics_resource_id        = "${dependency.logging.outputs.law_workspace_resource_id}"
  }
  management_nsg_rules = [
    {
      name                       = "allow-ssh"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    },
  ]
}
