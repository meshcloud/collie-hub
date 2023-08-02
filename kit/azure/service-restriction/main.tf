data "azurerm_policy_definition" "deny_resource_types" {
  name = "6c112d4e-5bc7-47ae-a041-ea2d9dccd749"
}

resource "azurerm_management_group_policy_assignment" "deny_resource_types" {
  name = "Deny Resource Types"
  policy_definition_id = data.azurerm_policy_definition.deny_resource_types.id
  management_group_id = var.management_group_id
  parameters = jsonencode ({
    listOfResourceTypesNotAllowed = {
      value = var.resource_types_not_allowed
    }
  })
}

