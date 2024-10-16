# set up an SPN for the BB execution

data "azuread_group" "project_admins" {
  # note: this group is managed via meshStack
  display_name = "devopstoolchain.buildingblocks-prod-admin"
}

resource "azuread_application" "starterkit" {
  display_name = "devops-toolchain-starterkit-buildingblock"
  description  = "This SPN is used by the Likvid Bank DevOps Toolchain team to automate starterkit buildingblocks"
  owners       = data.azuread_group.project_admins.members
}

resource "azuread_service_principal" "starterkit" {
  client_id                    = azuread_application.starterkit.client_id
  app_role_assignment_required = false
  owners                       = data.azuread_group.project_admins.members
}


data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
}

# allow reading the groups and users
resource "azuread_app_role_assignment" "starterkit-directory" {
  app_role_id        = data.azuread_service_principal.msgraph.app_role_ids["Directory.Read.All"]
  resource_object_id = data.azuread_service_principal.msgraph.object_id

  principal_object_id = azuread_service_principal.starterkit.object_id
}

# note this rotation technique requires the terraform to be run regularly
resource "time_rotating" "key_rotation" {
  rotation_days = 365
}

resource "azuread_service_principal_password" "starterkit" {
  service_principal_id = azuread_service_principal.starterkit.id
  rotate_when_changed = {
    rotation = time_rotating.key_rotation.id
  }
}

# grant access to the terraform state
moved {
  from = azurerm_role_assignment.tfstates_engineers
  to   = azurerm_role_assignment.terraform_state
}
