locals {
  builtin_azurerm_policy_definition_names = {
    allowed_locations                 = "e56962a6-4747-49cd-b67b-bf8b01975c4c"
    allowed_locations_resource_groups = "e765b5de-1225-4ba3-bd56-1ac6695af988"
  }
}

data "azurerm_management_group" "root" {
  name = var.parent_mg_id
}

data "azurerm_policy_definition" "allowed_locations" {
  name = local.builtin_azurerm_policy_definition_names.allowed_locations
}

data "azurerm_policy_definition" "allowed_locations_resource_groups" {
  name = local.builtin_azurerm_policy_definition_names.allowed_locations_resource_groups
}

resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  name                 = "allowed locations"
  description          = data.azurerm_policy_definition.allowed_locations.description
  policy_definition_id = data.azurerm_policy_definition.allowed_locations.id
  management_group_id  = data.azurerm_management_group.root.id
  parameters = jsonencode({
    listOfAllowedLocations = {
      value = var.allowed_locations
    }
  })
}

resource "azurerm_management_group_policy_assignment" "allowed_locations_resource_groups" {
  name                 = "allowed locations rgs"
  description          = data.azurerm_policy_definition.allowed_locations_resource_groups.description
  policy_definition_id = data.azurerm_policy_definition.allowed_locations_resource_groups.id
  management_group_id  = data.azurerm_management_group.root.id
  parameters = jsonencode({
    listOfAllowedLocations = {
      value = var.allowed_locations
    }
  })
}