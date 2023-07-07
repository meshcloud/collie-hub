# define shared configuration here that's included by all terragrunt configurations in this platform
locals {
  platform = yamldecode(regex("^---([\\s\\S]*)\\n---\\n[\\s\\S]*$", file(".//README.md"))[0])
}

# terragrunt does not support azure remote_state, so we use a traditional generate block
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "azurerm" {
    use_azuread_auth     = true 
    tenant_id            = "${local.platform.azure.aadTenantId}"
    subscription_id      = "${local.platform.azure.subscriptionId}"
    resource_group_name  = "foundation-tfstates"
    storage_account_name = TODO-UNIQUE-NAME-HERE
    container_name       = "tfstates"
    key                  = "${path_relative_to_include()}.tfstate"
  }
}
EOF
}

# recommended: enable documentation generation for kit modules
inputs = {
  output_md_file = "${get_path_to_repo_root()}/../output.md"
}
