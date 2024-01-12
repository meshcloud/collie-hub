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

  azurerm_firewall = "likvid-fw"

  # these are example firewall rules for your tenant

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
  # firewall_application_rules = [
  #   {
  #     name             = "microsoft"
  #     action           = "Allow"
  #     source_addresses = ["10.1.0.0/24"]
  #     target_fqdns     = ["*.microsoft.com"]
  #     protocol = {
  #       type = "Http"
  #       port = "80"
  #     }
  #   }
  # ]
  # firewall_nat_rules = [
  #   {
  #     name                  = "natrule"
  #     action                = "Dnat"
  #     source_addresses      = ["192.168.1.0/24"]
  #     destination_ports     = ["80"]
  #     destination_addresses = ["public_ip"]
  #     protocols             = ["TCP"]
  #     translated_address    = "10.1.0.1"
  #     translated_port       = "8080"
  #   }
  # ]
}
