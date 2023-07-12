# define shared configuration here that most non-bootstrap modules in this platform want to include

# optional: make collie's platform config available in terragrunt by parsing frontmatter
locals {
  platform = yamldecode(regex("^---([\\s\\S]*)\\n---\\n[\\s\\S]*$", file(".//README.md"))[0])
}

# optional: reference the bootstrap module to access its outputs
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
  tenant_id       = "${local.platform.azure.aadTenantId}"
  subscription_id = "${local.platform.azure.subscriptionId}" # todo: might need to target different subscriptions
  client_id       = "${dependency.bootstrap.outputs.client_id}"
  client_secret   = "${dependency.bootstrap.outputs.client_secret}"
}

provider "azuread" {
  tenant_id       = "${local.platform.azure.aadTenantId}"
  client_id       = "${dependency.bootstrap.outputs.client_id}"
  client_secret   = "${dependency.bootstrap.outputs.client_secret}"
}
EOF
}