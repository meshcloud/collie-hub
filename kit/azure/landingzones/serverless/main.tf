resource "azurerm_management_group" "serverless" {
  display_name               = var.lz-serverless
  parent_management_group_id = var.parent_management_group_id
}

module "policy_serverless" {
  source = "github.com/meshcloud/collie-hub//kit/azure/util/azure-policies?ref=ef06c8d"

  policy_path         = "${path.module}/lib"
  management_group_id = azurerm_management_group.serverless.id
  location            = var.location

  template_file_variables = {
    default_location          = var.location
    current_scope_resource_id = azurerm_management_group.serverless.id
    root_scope_resource_id    = azurerm_management_group.serverless.id
  }
}
