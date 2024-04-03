include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

# we deploy to the management subscription here, as budget alerts are central to all LZs
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

dependency "bootstrap" {
  config_path = "../../bootstrap"
}

dependency "organization-hierarchy" {
  config_path = "../../organization-hierarchy"
}

dependency "automation" {
  config_path = "../automation"
}

terraform {
  source = "${get_repo_root()}//kit/azure/buildingblocks/budget-alert"
}

inputs = {
  name          = "budget-alert"
  scope         = dependency.organization-hierarchy.outputs.landingzones_id
  principal_ids = toset([dependency.automation.outputs.principal_id])
}

# generate a config.tf file for automating building block deployments via meshStack
generate "config" {
  path      = "${get_terragrunt_dir()}/../budget-alert.test/config.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "azurerm" {
    use_azuread_auth      = true
    tenant_id             = "${dependency.automation.outputs.tenant_id}"
    subscription_id       = "${dependency.automation.outputs.subscription_id}"
    resource_group_name   = "${dependency.automation.outputs.resource_group_name}"
    storage_account_name  = "${dependency.automation.outputs.storage_account_name}"
    container_name        = "${dependency.automation.outputs.container_name}"
    key                   = "budget-alert.tfstate"

    client_id             = "${dependency.automation.outputs.client_id}"
    client_secret         = "${dependency.automation.outputs.client_secret}"
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = false
  storage_use_azuread        = true

  tenant_id       = "${dependency.automation.outputs.tenant_id}"

  # this var will be injected by the buildingblock runner
  subscription_id = var.subscription_id

  client_id             = "${dependency.automation.outputs.client_id}"
  client_secret         = "${dependency.automation.outputs.client_secret}"
}
EOF
}
