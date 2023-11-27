include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

dependency "bootstrap" {
  config_path = "${path_relative_from_include()}/bootstrap"
}

dependency "logging" {
  config_path = "${path_relative_from_include()}/logging"
}

dependency "billing" {
  config_path = "${path_relative_from_include()}/billing"
}

terraform {
  source = "${get_repo_root()}//kit/azure/pam"
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

provider "azuread" {
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
  client_id       = "${dependency.bootstrap.outputs.client_id}"
  client_secret   = "${dependency.bootstrap.outputs.client_secret}"
}
EOF
}


inputs = {
  pam_group_object_ids = [
    dependency.bootstrap.outputs.platform_engineers_azuread_group_id,
    dependency.billing.outputs.billing_admins_azuread_group_id,
    dependency.billing.outputs.billing_readers_azuread_group_id,
    dependency.logging.outputs.security_admins_azuread_group_id,
    dependency.logging.outputs.security_auditors_azuread_group_id,
  ]

  # optional, manage members direcly via terraform
  pam_group_members = [
    {
      group_object_id = dependency.billing.outputs.billing_admins_azuread_group_id,
      members_by_mail = ["billingmeshi@meshithesheep.io"]
    },
    {
      group_object_id = dependency.logging.outputs.security_admins_azuread_group_id,
      members_by_mail = ["securitymeshi@meshithesheep.io"]
    }

    # note: platform_engineers members are managed via bootstrap module right now
  ]
}

