module "subscription" {
  source = "../../../../../../../../../kit/azure/tenants/subscription"

  subscription_name       = "NAME-YOUR-SUBSCRIPTION"
  parent_management_group = "NAME-OF-THE-LANDINGZONE"
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
  connectivity_rg = "tenant-example-network"
  hub_rg          = "hub-vnet-rg"
  hub_vnet        = "hub-vnet"
  tenant_name     = "tenant-example"
  address_space   = ["10.1.0.0/24"]

  azurerm_firewall = "likvid-fw"

  # these are example firewall rules for your tenant
  # tenant firewall rules are subordinate to the rules deployed with the netowrking kit


  # Application Rules:
  # Permit access to specific applications or services based on application protocols.
  # They allow traffic between specific source addresses and target FQDNs using defined protocols and ports.

  #  firewall_application_rules = [
  #    {
  #      name             = "microsoft"
  #      action           = "Allow"
  #      source_addresses = ["10.1.0.0/24"]
  #      target_fqdns     = ["*.microsoft.com"]
  #      protocol = {
  #        type = "Http"
  #        port = "80"
  #      }
  #    }
  #  ]

  # Network Rules:
  # Enable traffic between source and destination addresses over specific ports and protocols.
  # Typically operate at the network level, allowing access to specific services like NTP (Network Time Protocol)
  # over UDP port 123, for example.

  #  firewall_network_rules = [
  #   {
  #     name                  = "ntp"
  #     action                = "Allow"
  #     source_addresses      = ["10.1.0.0/24"]
  #     destination_ports     = ["123"]
  #     destination_addresses = ["*"]
  #     protocols             = ["UDP"]
  #   }
  #  ]

  # NAT Rules (Network Address Translation):
  # Control the translation of IP addresses and ports in network traffic.
  # These rules facilitate the redirection of inbound or outbound traffic by modifying source or destination
  # addresses and/or ports.
  # In the given example, traffic from source address 192.168.1.0/24 reaching TCP port 80 is redirected
  # to the destination address public_ip with port 8080.

  #  firewall_nat_rules = [
  #    {
  #      name                  = "natrule"
  #      action                = "Dnat"
  #      source_addresses      = ["192.168.1.0/24"]
  #      destination_ports     = ["80"]
  #      destination_addresses = ["public_ip"]
  #      protocols             = ["TCP"]
  #      translated_address    = "10.1.0.1"
  #      translated_port       = "8080"
  #    }
  #  ]
}
