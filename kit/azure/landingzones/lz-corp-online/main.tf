
resource "azurerm_management_group" "corp" {
  display_name               = var.corp
  parent_management_group_id = var.parent_management_group_id
}

resource "azurerm_management_group" "online" {
  display_name               = var.online
  parent_management_group_id = var.parent_management_group_id
}

module "policy_corp" {
  source = "github.com/meshcloud/collie-hub//kit/azure/util/azure-policies?ref=ef06c8d"

  policy_path         = "${path.module}/lib/corp"
  management_group_id = azurerm_management_group.corp.id
  location            = var.location

  template_file_variables = {
    default_location          = "${var.location}"
    connectivity_location          = "${var.location}"
    current_scope_resource_id = azurerm_management_group.corp.id
    root_scope_resource_id    = azurerm_management_group.corp.id
  }
}

module "policy_online" {
  source = "github.com/meshcloud/collie-hub//kit/azure/util/azure-policies?ref=ef06c8d"

  policy_path         = "${path.module}/lib/online"
  management_group_id = azurerm_management_group.online.id
  location            = var.location

  template_file_variables = {
    default_location          = "${var.location}"
    current_scope_resource_id = azurerm_management_group.online.id
    root_scope_resource_id    = azurerm_management_group.online.id
  }
}
