data "azurerm_subscription" "current" {
}

#
# Hub Deploy Roles
#

# note: this role will be assigned using the access role above
resource "azurerm_role_definition" "buildingblock_deploy_hub" {
  name        = "buildingblock-${var.name}-deploy-hub"
  description = "Enables deployment of the ${var.name} building block to the hub"
  scope       = data.azurerm_subscription.current.id # assume we are running in the hub subscription anyway

  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/*",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/write",
      "Microsoft.Network/virtualNetworks/delete",
      "Microsoft.Network/virtualNetworks/subnets/*",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/*",
      "Microsoft.Network/virtualNetworks/peer/action",

      # Permission we need to activate/register required Resource Providers
      "Microsoft.Resources/subscriptions/providers/read",
      "*/register/action",
    ]
  }
}

resource "azurerm_role_assignment" "buildingblock_deploy_hub" {
  for_each = var.principal_ids

  role_definition_id = azurerm_role_definition.buildingblock_deploy_hub.role_definition_resource_id
  description        = azurerm_role_definition.buildingblock_deploy_hub.description
  principal_id       = each.key
  scope              = data.azurerm_subscription.current.id # assume we are running in the spoke subscription anyway
}
