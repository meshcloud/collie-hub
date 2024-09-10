resource "azurerm_management_group" "container_platform" {
  display_name               = var.name
  parent_management_group_id = var.parent_management_group_id
}

resource "azurerm_management_group" "dev" {
  display_name               = "${var.name}-dev"
  parent_management_group_id = azurerm_management_group.container_platform.id

  lifecycle {
    ignore_changes = [subscription_ids]
  }
}

resource "azurerm_management_group" "prod" {
  display_name               = "${var.name}-prod"
  parent_management_group_id = azurerm_management_group.container_platform.id

  lifecycle {
    ignore_changes = [subscription_ids]
  }
}

module "policy_container_platform" {
  source = "github.com/meshcloud/collie-hub//kit/azure/util/azure-policies?ref=7c356a7"

  policy_path         = "${path.module}/lib"
  management_group_id = azurerm_management_group.container_platform.id
  location            = var.location

  template_file_variables = {
    default_location          = "${var.location}"
    current_scope_resource_id = azurerm_management_group.container_platform.id
  }
}
