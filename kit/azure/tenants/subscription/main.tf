data "azurerm_subscription" "current" {
}

// set name, tags
resource "azurerm_subscription" "this" {
  subscription_id   = data.azurerm_subscription.current.subscription_id
  subscription_name = var.subscription_name
}

// Select the parent management group.
// We simply put in a data reference lookup here instead of using a terragrunt dependency since this is faster to
// execute (no tf state lookup to fetch the output), less complexity (less code to get the same value).
// Also tenants are arguably a different "level" of deployments separate from core infrastructure
data "azurerm_management_group" "lz" {
  display_name = var.parent_management_group
}

// control placement in the LZ hierarchy
resource "azurerm_management_group_subscription_association" "lz" {
  management_group_id = data.azurerm_management_group.lz.id
  subscription_id     = data.azurerm_subscription.current.id
}
