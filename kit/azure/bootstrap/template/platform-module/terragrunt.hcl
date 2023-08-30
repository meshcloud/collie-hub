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

inputs = {
  # for creation of the resource_group and storage container we are using the
  # https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_naming_convention
  # you only need the the name of your foundation like likvid the result would like rg-tfstate-likvid-ewt

  resources_cloudfoundation = "cloudfoundation"           #TODO change, name your rg fo the statefiles
  service_principal_name    = "cloudfoundation_tf_deploy" #TODO change, name your spn

  terraform_state_storage = {
    location = "germanywestcentral" #TODO change, the location where your bucket live
  }

  platform_engineers_members = [{
    email = "meshi@meshithesheep.io"             #TODO change, enter PLATFORM ENGINEERS MAIL here
  upn = "meshi@meshithesheep.onmicrosoft.com" }] #TODO change, enter PLATFORM ENGINEERS UPN here

  file_path     = include.platform.locals.file_path
  aad_tenant_id = include.platform.locals.platform.azure.aadTenantId
}
