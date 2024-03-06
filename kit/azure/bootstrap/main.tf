data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_management_group" "root" {
  name = data.azurerm_subscription.current.tenant_id
}

module "terraform_state" {
  count = var.terraform_state_storage != null ? 1 : 0

  source                           = "./terraform-state"
  location                         = var.terraform_state_storage.location
  cloudfoundation                  = var.terraform_state_storage.name
  terraform_state_config_file_path = var.terraform_state_storage.config_file_path
  uami_documentation_spn           = var.uami_documentation_spn
  uami_documentation_issuer        = var.uami_documentation_issuer
  uami_documentation_name          = var.uami_documentation_name
  uami_documentation_subject       = var.uami_documentation_subject
}

# Set permissions on the blob store
resource "azurerm_role_assignment" "tfstates_engineers" {
  count = var.terraform_state_storage != null ? 1 : 0

  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_group.platform_engineers.object_id
  scope                = module.terraform_state[0].container_id
}

data "azuread_users" "platform_engineers_members" {
  # unfortunately mail_nicknames attribute does not work on our AADs because we don't sync from on-premise
  # so we have to use user prinicpal names for lookups
  user_principal_names = var.platform_engineers_members[*].upn
}

resource "azuread_group" "platform_engineers" {
  display_name     = var.platform_engineers_group
  description      = "Privileged Cloud Foundation group. Members have full access to deploy cloud foundation infrastructure and landing zones."
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id] # todo: possibly the owner needs to be the cloudfoundation SPN? need to figure out dependency order inside the boostrap module!

  members = toset(data.azuread_users.platform_engineers_members.object_ids)
}
