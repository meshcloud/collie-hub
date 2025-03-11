resource "azurerm_role_definition" "buildingblock_deploy" {
  name        = "${var.name}-deploy"
  description = "Enables deployment of the ${var.name} building block to subscriptions"
  scope       = var.scope
  permissions {
    actions = [
      "Microsoft.DBforPostgreSQL/servers/write",
      "Microsoft.DBforPostgreSQL/servers/read",
      "Microsoft.DBforPostgreSQL/servers/delete",
      "Microsoft.DBforPostgreSQL/servers/firewallRules/read",
      "Microsoft.DBforPostgreSQL/servers/firewallRules/write"
    ]
  }
}

resource "azurerm_role_assignment" "buildingblock_deploy" {
  for_each = var.principal_ids

  role_definition_id = azurerm_role_definition.buildingblock_deploy.role_definition_resource_id
  principal_id       = each.value
  scope              = var.scope
}
