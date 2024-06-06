dependency "bootstrap" {
  config_path = "../../bootstrap"
}

dependency "automation" {
  config_path = "../automation"
}

terraform {
  source = "${get_repo_root()}//kit/azure/buildingblocks/github-repo"
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
EOF
}

# generate a terraform.tfvars file for automating building block deployments via meshStack
generate "tfvars" {
  path      = "${get_terragrunt_dir()}/../github-repo.test/terrafrom.tfvars"
  if_exists = "overwrite"
  contents  = <<EOF
    key_vault_name = ${dependency.bootstrap.outputs.azurerm_key_vault.name}
    key_vault_rg   = ${dependency.bootstrap.outputs.azurerm_key_vault_rg_name}
  }
EOF
}
