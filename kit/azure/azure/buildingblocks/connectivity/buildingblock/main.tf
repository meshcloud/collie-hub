#
# 1. deploy the resource group
#
data "azurerm_client_config" "spoke" {
  provider = azurerm.spoke
}

resource "azurerm_resource_group" "spoke_rg" {
  provider = azurerm.spoke

  name     = "connectivity"
  location = var.location
}

#
# 2.assign permission to deploy resource in that specific RG
#
resource "azurerm_role_assignment" "spoke_rg" {
  provider = azurerm.spoke

  role_definition_name = "Owner"
  principal_id         = coalesce(var.spoke_owner_principal_id, data.azurerm_client_config.spoke.object_id)
  scope                = azurerm_resource_group.spoke_rg.id
}

#
# 3. deploy the actual network
#
resource "azurerm_virtual_network" "spoke_vnet" {
  provider   = azurerm.spoke
  depends_on = [azurerm_role_assignment.spoke_rg]

  name                = "${var.name}-vnet"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name
  address_space       = [var.address_space]
}

#
# 4. establish the peering
#
data "azurerm_resource_group" "hub_rg" {
  provider = azurerm.hub
  name     = var.hub_rg
}

data "azurerm_virtual_network" "hub_vnet" {
  provider = azurerm.hub

  name                = var.hub_vnet
  resource_group_name = data.azurerm_resource_group.hub_rg.name
}

resource "azurerm_virtual_network_peering" "spoke_hub_peer" {
  provider = azurerm.spoke

  name                      = var.name
  resource_group_name       = azurerm_resource_group.spoke_rg.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.hub_vnet.id
}

resource "azurerm_virtual_network_peering" "hub_spoke_peer" {
  provider = azurerm.hub

  name                      = var.name
  resource_group_name       = data.azurerm_resource_group.hub_rg.name
  virtual_network_name      = data.azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id
}
