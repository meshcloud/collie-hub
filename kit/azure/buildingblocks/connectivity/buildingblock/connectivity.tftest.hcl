run "verify" {
  variables {
    name          = "terraform-test"
    address_space = "10.123.123.0/24"
  }

  assert {
    condition     = azurerm_virtual_network.spoke_vnet.name == "terraform-test-vnet"
    error_message = "invalid vnet name, actual ${azurerm_virtual_network.spoke_vnet.name}"
  }

  assert {
    # jsonencode to work around terraform type limitations
    condition     = jsonencode(azurerm_virtual_network.spoke_vnet.address_space) == jsonencode(["10.123.123.0/24"])
    error_message = "invalid address space, actual: ${jsonencode(azurerm_virtual_network.spoke_vnet.address_space)}"
  }
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
