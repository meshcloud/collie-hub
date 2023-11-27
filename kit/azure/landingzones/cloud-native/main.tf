resource "azurerm_management_group" "cloudnative" {
  display_name               = var.name
  parent_management_group_id = var.parent_management_group_id
}

resource "azurerm_management_group" "dev" {    
  display_name               = "${var.name}-dev"
  parent_management_group_id = azurerm_management_group.cloudnative.id

  lifecycle {
    ignore_changes = [ subscription_ids ]
  }
}

resource "azurerm_management_group" "prod" {
  display_name               = "${var.name}-prod"
  parent_management_group_id = azurerm_management_group.cloudnative.id
  
  lifecycle {
    ignore_changes = [ subscription_ids ]
  }
}