module "subscription" {
  source = "github.com/meshcloud/collie-hub/kit/azure/buildingblocks/subscription"
  # Use local sources for testing
  #source = "../../../../../../../../../kit/azure/buildingblocks/subscription"

  subscription_name       = "tenant-example"
  parent_management_group = "cloudnative"
}

module "connectivity" {
  source = "github.com/meshcloud/collie-hub/kit/azure/buildingblocks/connectivity"
  # Use local sources for testing
  #source   = "../../../../../../../../../kit/azure/buildingblocks/connectivity"

  providers = {
    azurerm.spoke = azurerm
    azurerm.hub   = azurerm.hub
  }

  location        = "germanywestcentral"
  connectivity_rg = "tenant-example"
  hub_rg          = "hub-vnet-rg"
  hub_vnet        = "hub-vnet"
  tenant_name     = "tenant-example"
  address_space   = ["10.1.0.0/24"]

  #azurerm_firewall = "likvid-fw"

  # firewall_network_rules = [
  #  {
  #    name                  = "ntp"
  #    action                = "Allow"
  #    source_addresses      = ["10.1.0.0/24"]
  #    destination_ports     = ["123"]
  #    destination_addresses = ["*"]
  #    protocols             = ["UDP"]
  #  }
  # ]
}
