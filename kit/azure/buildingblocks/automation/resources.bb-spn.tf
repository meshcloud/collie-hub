resource "azuread_application" "buildingblock" {
  display_name = var.service_principal_name
  description  = "This SPN is used by the Likvid Bank Cloud Foundation team to automate buildingblocks"
}

resource "azuread_service_principal" "buildingblock" {
  client_id                    = azuread_application.buildingblock.client_id
  app_role_assignment_required = false
}

data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
}

# allow reading groups and users
resource "azuread_app_role_assignment" "buildingblock-directory" {
  app_role_id        = data.azuread_service_principal.msgraph.app_role_ids["Directory.Read.All"]
  resource_object_id = data.azuread_service_principal.msgraph.object_id

  principal_object_id = azuread_service_principal.buildingblock.object_id
}

# note this rotation technique requires the terraform to be run regularly
resource "time_rotating" "key_rotation" {
  rotation_days = 365
}

resource "azuread_service_principal_password" "buildingblock" {
  service_principal_id = azuread_service_principal.buildingblock.id
  rotate_when_changed = {
    rotation = time_rotating.key_rotation.id
  }
}