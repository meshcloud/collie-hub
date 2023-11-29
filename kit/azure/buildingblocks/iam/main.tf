data "azurerm_subscription" "current" {
}

data "azuread_group" "readers" {
  count        = var.group_name_readers != null ? 1 : 0
  display_name = var.group_name_readers
}

resource "azurerm_role_assignment" "readers" {
  count = var.group_name_readers != null ? 1 : 0

  principal_id         = data.azuread_group.readers[0].object_id
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Reader"
}
