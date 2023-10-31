include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

dependency "bootstrap" {
  config_path = "${path_relative_from_include()}/bootstrap"
}

dependency "activity-log" {
  config_path = "${path_relative_from_include()}/activity-log"
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
EOF
}

inputs = {
  billing_admin_members = [
    {
      email = "financemeshi@meshithesheep.io" #TODO change, enter BILLING ADMIN MAIL here
      upn   = "financemeshi@meshithesheep.onmicrosoft.com"
    }
  ]
  billing_reader_members = [
    {
      email = "financemeshi@meshithesheep.io" #TODO change, enter BILLING READER MAIL here
      upn   = "financemeshi@meshithesheep.onmicrosoft.com"
    }
  ]
  security_auditor_group = "${dependency.activity-log.outputs.security_auditors_azuread_group_id}"
  security_auditor_members = [
    {
      email = "securitymeshi@meshithesheep.io" #TODO change, enter Security AUDITOR MAIL here
      upn   = "securitymeshi@meshithesheep.onmicrosoft.com"
    }
  ]
}
