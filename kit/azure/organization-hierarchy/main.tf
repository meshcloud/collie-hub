resource "azurerm_management_group" "parent" {
  display_name = var.parentManagementGroup
  name         = var.parentManagementGroup

}

resource "azurerm_management_group" "landingzones" {
  display_name               = var.landingzones
  parent_management_group_id = azurerm_management_group.parent.id
  depends_on = [
    azurerm_management_group.parent
  ]
}

resource "azurerm_management_group" "corp" {
  display_name               = var.corp
  parent_management_group_id = azurerm_management_group.landingzones.id
  depends_on = [
    azurerm_management_group.landingzones
  ]

}
resource "azurerm_management_group" "online" {
  display_name               = var.online
  parent_management_group_id = azurerm_management_group.landingzones.id
  depends_on = [
    azurerm_management_group.landingzones
  ]
}

resource "azurerm_management_group" "platform" {
  display_name               = var.platform
  parent_management_group_id = azurerm_management_group.parent.id
  depends_on = [
    azurerm_management_group.parent
  ]

}
resource "azurerm_management_group" "connectivity" {
  display_name               = var.connectivity
  parent_management_group_id = azurerm_management_group.platform.id
  depends_on = [
    azurerm_management_group.platform
  ]

}

resource "azurerm_management_group" "identity" {
  display_name               = var.identity
  parent_management_group_id = azurerm_management_group.platform.id
  depends_on = [
    azurerm_management_group.platform
  ]
}

resource "azurerm_management_group" "management" {
  display_name               = var.management
  parent_management_group_id = azurerm_management_group.platform.id
  depends_on = [
    azurerm_management_group.platform
  ]
}

# Move management subscription into the new organization hierarchy
data "azurerm_subscription" "current" {
}

resource "azurerm_management_group_subscription_association" "management" {
  management_group_id = azurerm_management_group.management.id
  subscription_id     = data.azurerm_subscription.current.id
}
