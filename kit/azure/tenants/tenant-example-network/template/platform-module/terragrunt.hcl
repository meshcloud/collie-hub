include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

// this is not a standard platform module that uses a kit module, instead we call this a "tenant module"
// that contains its own terraform code and just pulls in plain terraform modules (building blocks) for reusable modules
#terraform {

terraform {
  source = "./"
}

dependency "bootstrap" {
  config_path = "../../bootstrap"
}

dependency "networking" {
  config_path = "../../networking"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azurerm" {
  features {}
  skip_provider_registration = true
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
  subscription_id = "the-id-of-your-subscription"
}

provider "azurerm" {
  features {}
  alias           = "hub"
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
  subscription_id = "${dependency.networking.outputs.hub_subscription}"
}
EOF
}
