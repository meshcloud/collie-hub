resource "azurerm_role_definition" "buildingblock_deploy" {
  name        = "${var.name}-deploy"
  description = "Enables deployment of the ${var.name} building block to subscriptions"
  scope       = var.scope

  permissions {
    actions = [
      # Reading management groups
      "Microsoft.Management/managementGroups/read",
      "Microsoft.Management/managementGroups/descendants/read",

      # Permissions to move subscriptions between management groups
      "Microsoft.Management/managementgroups/subscriptions/delete",
      "Microsoft.Management/managementgroups/subscriptions/write",

      # Rename a subscription
      "Microsoft.Subscription/rename/action",

      # Permissions for reading and writing tags
      "Microsoft.Resources/tags/*",

      # Permission we need to activate/register required Resource Providers
      "*/register/action",
    ]
  }
}

resource "azurerm_role_assignment" "buildingblock_deploy" {
  for_each = var.principal_ids

  role_definition_id = azurerm_role_definition.buildingblock_deploy.role_definition_resource_id
  principal_id       = each.value
  scope              = var.scope
}
