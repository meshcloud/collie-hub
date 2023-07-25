include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
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
  resource_group_tfstate = "cloudfoundation_tfstate" #TODO change, name your rg fo the statefiles
  service_principal_name = "cloudfoundation_tf_deploy" #TODO change, name your spn
  location = "germanywestcentral" #TODO change, the location where your bucket live
  upn_domain = "#EXT#@devmeshithesheep.onmicrosoft.com"
  platform_engineers_emails = [
    "meshi@meshithesheep.io" # #TODO change, enter PLATFORM ENGINEERS here
  ]

  # TODO: Usefull if you need to translate emails into UPNs as necessary, shown here with guest users
  # change the upn_domain value above
  platform_engineers_members = [
    for x in local.platform_engineers_emails : {
      email = x
      upn   = "${replace(x, "@", "_")}${local.upn_domain}"
    }
  ]
}

inputs = {
  file_path = include.platform.locals.file_path
  aad_tenant_id = include.platform.locals.platform.azure.aadTenantId
  resource_group_tfstate = local.resource_group_tfstate
  platform_engineers_members = local.platform_engineers_members
  service_principal_name     = local.service_principal_name
  terraform_state_storage = {
    location = local.location
  }
}
