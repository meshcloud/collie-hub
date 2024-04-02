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


# this is sometimes flaky: add additional sync checks

# ╷
# │ Error: waiting for Virtual Network Peering: (Name "terraform-test" / Virtual Network Name "hub-vnet" / Resource Group "likvid-hub-vnet-rg") to be created: network.VirtualNetworkPeeringsClient#CreateOrUpdate: Failure sending request: StatusCode=403 -- Original Error: Code="LinkedAuthorizationFailed" Message="The client 'dca119ef-092d-41ce-83d3-920d4eda271a' with object id 'dca119ef-092d-41ce-83d3-920d4eda271a' has permission to perform action 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings/write' on scope '/subscriptions/5066eff7-4173-4fea-8c67-268456b4a4f7/resourceGroups/likvid-hub-vnet-rg/providers/Microsoft.Network/virtualNetworks/hub-vnet/virtualNetworkPeerings/terraform-test'; however, it does not have permission to perform action(s) 'Microsoft.Network/virtualNetworks/peer/action' on the linked scope(s) '/subscriptions/c4a1f7bc-9a89-4a8d-a03f-3df5c639bd5d/resourceGroups/connectivity/providers/Microsoft.Network/virtualNetworks/terraform-test-vnet' (respectively) or the linked scope(s) are invalid."
# │
# │   with azurerm_virtual_network_peering.hub_spoke_peer,
# │   on main.tf line 64, in resource "azurerm_virtual_network_peering" "hub_spoke_peer":
# │   64: resource "azurerm_virtual_network_peering" "hub_spoke_peer" {
# │
# ╵
# integration.tftest.hcl... fail

# Failure! 0 passed, 1 failed.
# ERRO[0163] terraform invocation failed in /Users/jrudolph/dev/mc/likvid-cloudfoundation/foundations/likvid-prod/platforms/azure/buildingblocks/connectivity.test/.terragrunt-cache/oOe4Dx4PzIk_W5GjrRfnDKuz-Yk/Y5Jm2BYHj1OMAGX-ddMr-eJBvFs/kit/azure/buildingblocks/connectivity/buildingblock  prefix=[/Users/jrudolph/dev/mc/likvid-cloudfoundation/foundations/likvid-prod/platforms/azure/buildingblocks/connectivity.test]
# ERRO[0163] 1 error occurred:
#         * [/Users/jrudolph/dev/mc/likvid-cloudfoundation/foundations/likvid-prod/platforms/azure/buildingblocks/connectivity.test/.terragrunt-cache/oOe4Dx4PzIk_W5GjrRfnDKuz-Yk/Y5Jm2BYHj1OMAGX-ddMr-eJBvFs/kit/azure/buildingblocks/connectivity/buildingblock] exit status 1