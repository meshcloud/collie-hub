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
EOF
}

inputs = {

  billing_admin = {
    group = {
      object_id    = "${dependency.billing.outputs.billing_admins_azuread_group_id}",
      display_name = "${dependency.billing.outputs.billing_admins_azuread_group_displayname}"
    }
  }

  billing_reader = {
    group = {
      object_id    = "${dependency.billing.outputs.billing_readers_azuread_group_id}",
      display_name = "${dependency.billing.outputs.billing_readers_azuread_group_displayname}"
    }
  }

  security_admin = {
    group = {
      object_id    = "${dependency.logging.outputs.security_admins_azuread_group_id}",
      display_name = "${dependency.logging.outputs.security_admins_azuread_group_displayname}"
    }
  }
  security_auditor = {
    group = {
      object_id    = "${dependency.logging.outputs.security_auditors_azuread_group_id}",
      display_name = "${dependency.logging.outputs.security_auditors_azuread_group_displayname}"
    }
  }
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
  security_admin_group = "${dependency.activity-log.outputs.security_admins_azuread_group_id}"
  security_admin_members = [
    {
      email = "securitymeshi@meshithesheep.io" #TODO change, enter SECURITY ADMINS MAIL here
      upn   = "securitymeshi@meshithesheep.onmicrosoft.com"
    }
  ]
  security_auditor_group = "${dependency.activity-log.outputs.security_auditors_azuread_group_id}"
  security_auditor_members = [
    {
      email = "securitymeshi@meshithesheep.io" #TODO change, enter SECURITY AUDITOR MAIL here
      upn   = "securitymeshi@meshithesheep.onmicrosoft.com"
    }
  ]
}
