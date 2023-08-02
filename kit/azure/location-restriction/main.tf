data "azurerm_policy_definition" "deny_resource_locations" {
  name = "e56962a6-4747-49cd-b67b-bf8b01975c4c"
}

resource "azurerm_management_group_policy_assignment" "deny_resource_locations" {
  name = "Deny Resource Locations"
  policy_definition_id = data.azurerm_policy_definition.deny_resource_locations.id
  management_group_id = var.management_group_id
  parameters = jsonencode ({
    listOfAllowedLocations = {
      value = var.allowed_locations
    }
  })
}

data "azurerm_policy_definition" "deny_rsg_locations" {
  name = "e765b5de-1225-4ba3-bd56-1ac6695af988"
}

resource "azurerm_management_group_policy_assignment" "deny_rsg_locations" {
  name = "Deny RSG Locations"
  policy_definition_id = data.azurerm_policy_definition.deny_rsg_locations.id
  management_group_id = var.management_group_id
  parameters = jsonencode ({
    listOfAllowedLocations = {
      value = var.allowed_locations
    }
  })
}

