include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

# This is a bootstrap module, so we set up a provider using local user credentials.
# This is called "az CLI based authentication", see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azurerm" {
  features {}
  skip_provider_registration = false
  tenant_id                  = "${include.platform.locals.platform.azure.aadTenantId}"
  subscription_id            = "${include.platform.locals.platform.azure.subscriptionId}"
  storage_use_azuread        = true
}

provider "azuread" {
  tenant_id = "${include.platform.locals.platform.azure.aadTenantId}"
}
EOF
}


locals {
  platform_engineers_emails = [
    # TODO ENTER PLATFORM ENGINEERS HERE
  ]

  # TODO: Usefull if you need to translate emails into UPNs as necessary, shown here with guest users
  platform_engineers_members = [
    for x in local.platform_engineers_emails : {
      email = x
      upn   = "${replace(x, "@", "_")}#EXT#@example.onmicrosoft.com"
    }
  ]
}

terraform {
  source = "${get_repo_root()}//kit/azure/bootstrap"

  # Technically we could assume the right subscription is set via the provider.tf config already, but it seems that's
  # not sufficient, we still see authentication errors (and long timeouts) unless the right subscription is configured
  # explicitly before running terraform - so we just do that to be sure.
  # This will only affect the az cli configuration stored in $AZURE_CONFIG_DIR
  before_hook "az_account_set" {
    commands = ["apply", "plan"]
    execute  = ["az", "account", "set", "--subscription", "${include.platform.locals.platform.azure.subscriptionId}"]
  }
}

inputs = {
  aad_tenant_id = include.platform.locals.platform.azure.aadTenantId
  platform_engineers_members = local.platform_engineers_members
  service_principal_name     = "cloudfoundation_tf_deploy_user" # TODO: Pick a name
  terraform_state_storage = {
    location = "germanywestcentral" # TODO: Pick a location
  }
}