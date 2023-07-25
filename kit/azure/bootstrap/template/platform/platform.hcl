locals {
# define shared configuration here that's included by all terragrunt configurations in this locals 
  platform = yamldecode(regex("^---([\\s\\S]*)\\n---\\n[\\s\\S]*$", file(".//README.md"))[0])
  file_path   = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/tfstates-config.yml"
  tfstateconfig = try(yamldecode(file(local.file_path)), [])
}

# terragrunt does not support azure remote_state, so we use a traditional generate block
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
  %{ if fileexists(local.file_path) }
  terraform {
  backend "azurerm" {
    use_azuread_auth      = true 
    tenant_id             = "${local.platform.azure.aadTenantId}"
    subscription_id       = "${local.platform.azure.subscriptionId}"
    resource_group_name   = "${try(local.tfstateconfig.resource_group_name, "")}"
    storage_account_name  = "${try(local.tfstateconfig.storage_account_name, "")}"
    container_name        = "${try(local.tfstateconfig.container_name, "")}" 
    key                   = "${path_relative_to_include()}.tfstate"
    }
   }%{else}
  terraform {
  backend "local" {
  }
}
%{ endif }
 EOF
}