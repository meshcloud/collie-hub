locals {
  # define shared configuration here that's included by all terragrunt configurations in this locals
  platform        = yamldecode(regex("^---([\\s\\S]*)\\n---\\n[\\s\\S]*$", file(".//README.md"))[0])
  cloudfoundation = yamldecode(regex("^---([\\s\\S]*)\\n---\\n[\\s\\S]*$", file("../..//README.md"))[0])

  # if we use terraform_state_storage, it will generate this file here to provide backend configuration
  terraform_state_config_file_path = "${get_parent_terragrunt_dir()}/tfstates-config.yml"
  tfstateconfig                    = try(yamldecode(file(local.terraform_state_config_file_path)), null)
}

# terragrunt does not support azure remote_state, so we use a traditional generate block
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  %{if local.tfstateconfig != null}
  backend "azurerm" {
    use_azuread_auth      = true
    tenant_id             = "${local.platform.azure.aadTenantId}"
    subscription_id       = "${local.platform.azure.subscriptionId}"
    resource_group_name   = "${try(local.tfstateconfig.resource_group_name, "")}"
    storage_account_name  = "${try(local.tfstateconfig.storage_account_name, "")}"
    container_name        = "${try(local.tfstateconfig.container_name, "")}"
    key                   = "${path_relative_to_include()}.tfstate"
  }
  %{else}
  backend "local" {
  }
  %{endif}
}
EOF
}
