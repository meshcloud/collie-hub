locals {
  azure_delay = "${var.azure_delay_seconds}s"
}

data "azurerm_client_config" "spoke" {
  provider = azurerm.spoke
}

#
# 1. deploy the resource group
#

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

# Wait for the role assignment to become effective, azure is eventually consistent and thus sometimes flaky
# even though the azurerm_role_assignment provider tries to cover for that, it's not always effective.
# Example:
# > Error: checking for presence of existing Virtual Network (Subscription: "b53caa89-ba38-4f04-a0b2-f989c98d4add"
# > Resource Group Name: "connectivity"
# > Virtual Network Name: "vnet-demo-app-vnet"): network.VirtualNetworksClient#Get: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error. Status=403 Code="AuthorizationFailed" Message="The client 'dca119ef-092d-41ce-83d3-920d4eda271a' with object id 'dca119ef-092d-41ce-83d3-920d4eda271a' does not have authorization to perform action 'Microsoft.Network/virtualNetworks/read' over scope '/subscriptions/b53caa89-ba38-4f04-a0b2-f989c98d4add/resourceGroups/connectivity/providers/Microsoft.Network/virtualNetworks/vnet-demo-app-vnet' or the scope is invalid. If access was recently granted, please refresh your credentials."
resource "time_sleep" "wait_for_spoke_rg_role" {
  depends_on      = [azurerm_role_assignment.spoke_rg]
  create_duration = local.azure_delay
}

#
# 3. deploy the actual network
#
resource "azurerm_virtual_network" "spoke_vnet" {
  provider   = azurerm.spoke
  depends_on = [time_sleep.wait_for_spoke_rg_role]

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

# azure sometimes does not find the new spokle vnet for creating the peer, hence also giving this a delay
resource "time_sleep" "wait_before_peering" {
  depends_on      = [azurerm_virtual_network.spoke_vnet]
  create_duration = local.azure_delay
}

resource "azurerm_virtual_network_peering" "spoke_hub_peer" {
  provider   = azurerm.spoke
  depends_on = [time_sleep.wait_before_peering]

  name                      = var.name
  resource_group_name       = azurerm_resource_group.spoke_rg.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.hub_vnet.id
}

resource "azurerm_virtual_network_peering" "hub_spoke_peer" {
  provider   = azurerm.hub
  depends_on = [time_sleep.wait_before_peering]

  name                      = var.name
  resource_group_name       = data.azurerm_resource_group.hub_rg.name
  virtual_network_name      = data.azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id
}
