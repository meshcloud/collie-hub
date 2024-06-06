include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

dependency "bootstrap" {
  config_path = "../../../bootstrap"
}

dependency "automation" {
  config_path = "../../automation"
}

terraform {
  source = "${get_repo_root()}//kit/azure/buildingblocks/github-repo/backplane"
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

# generate a config.tf file for automating building block deployments via meshStack
generate "config" {
  path      = "${get_terragrunt_dir()}/../github-repo.test/config.tf"
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
      key                   = "github-repo.tfstate"

      client_id             = "${dependency.automation.outputs.client_id}"
      client_secret         = "${dependency.automation.outputs.client_secret}"
    }
  }

  provider "azurerm" {
    features {}
    skip_provider_registration = true
    tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
    subscription_id = "${include.platform.locals.platform.azure.subscriptionId}"
    storage_use_azuread = true

    client_id             = "${dependency.automation.outputs.client_id}"
    client_secret         = "${dependency.automation.outputs.client_secret}"
  }

EOF
}

# generate a terraform.tfvars fire for automating building block deployments via meshStack
generate "tfvars" {
  path      = "${get_terragrunt_dir()}/../github-repo.test/terrafrom.tfvars"
  if_exists = "overwrite"
  contents  = <<EOF

  key_vault_name = "${dependency.bootstrap.outputs.azurerm_key_vault.name}"
  key_vault_rg   = "${dependency.bootstrap.outputs.azurerm_key_vault_rg_name}"
EOF
}

inputs = {
  key_vault_name           = dependency.bootstrap.outputs.azurerm_key_vault.name
  key_vault_rg             = dependency.bootstrap.outputs.azurerm_key_vault_rg_name
  github_token_secret_name = "name-of-secret"
}

