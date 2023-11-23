locals {
  # we use the first value of var.locations as the primary location where the policy lives.
  default_location = var.locations[0]
}

# location restriction
resource "azurerm_management_group" "parent" {
  display_name = var.parentManagementGroup
  name         = var.parentManagementGroup
}

module "policy_root" {
  source = "github.com/meshcloud/collie-hub//kit/azure/util/azure-policies?ref=da8dd49"

  policy_path         = "${path.module}/lib"
  management_group_id = azurerm_management_group.parent.id
  location            = local.default_location

  template_file_variables = {
    allowed_locations_json    = jsonencode(var.locations)
    default_location          = local.default_location
    current_scope_resource_id = azurerm_management_group.parent.id
    root_scope_resource_id    = azurerm_management_group.parent.id
  }
}

resource "azurerm_management_group" "landingzones" {
  display_name               = var.landingzones
  parent_management_group_id = azurerm_management_group.parent.id
}

resource "azurerm_management_group" "platform" {
  display_name               = var.platform
  parent_management_group_id = azurerm_management_group.parent.id
}

resource "azurerm_management_group" "connectivity" {
  display_name               = var.connectivity
  parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "identity" {
  display_name               = var.identity
  parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "management" {
  display_name               = var.management
  parent_management_group_id = azurerm_management_group.platform.id
}

# Move management subscription into the new organization hierarchy
# add this if moving the management group under the created hierardhy is desired
# data "azurerm_subscription" "current" {
# }

# resource "azurerm_management_group_subscription_association" "management" {
#   management_group_id = azurerm_management_group.management.id
#   subscription_id     = data.azurerm_subscription.current.id
# }
