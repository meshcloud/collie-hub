//------------------------------------------------------------------------------------------------------------
# Local variables
//------------------------------------------------------------------------------------------------------------
locals {

  prefix-hub                    = "hub"
  hub-location                  = "westeurope"
  hub-resource-group            = "hub-vnet-rg"
  hub-address_space             = ["10.0.0.0/16"]
  hub-gateway-address-prefixes  = ["10.0.2.0/24"]
  hub-bastion-address-prefixes  = ["10.0.1.0/24"]
  hub-firewall-address-prefixes = ["10.0.0.0/24"]
  shared-key                    = "4-v3ry-53cr37-1p53c-5h4r3d-k3y"

  admin_username = "azurevmuser"
}

//------------------------------------------------------------------------------------------------------------
# RESOURCE GROUP
//------------------------------------------------------------------------------------------------------------
resource "azurerm_resource_group" "hub-vnet-rg" {
  name     = local.hub-resource-group
  location = local.hub-location
}

//------------------------------------------------------------------------------------------------------------
# VIRTUAL NETWORK
//------------------------------------------------------------------------------------------------------------
resource "azurerm_virtual_network" "hub-vnet" {
  name                = "${local.prefix-hub}-vnet"
  location            = azurerm_resource_group.hub-vnet-rg.location
  resource_group_name = azurerm_resource_group.hub-vnet-rg.name
  address_space       = local.hub-address_space

  tags = {
    environment = "hub-spoke"
  }
}


//------------------------------------------------------------------------------------------------------------
# SUBNETS
//------------------------------------------------------------------------------------------------------------

resource "azurerm_subnet" "hub-gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = local.hub-gateway-address-prefixes
}

resource "azurerm_subnet" "hub-bastion" {
  name                 = "bastion-host"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = local.hub-bastion-address-prefixes

}

resource "azurerm_subnet" "azurefirewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = local.hub-firewall-address-prefixes
}


//------------------------------------------------------------------------------------------------------------
# Network Security Groups
//------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_group" "bastion_NSG" {
  name                = "bastion-nsg"
  location            = azurerm_resource_group.hub-vnet-rg.location
  resource_group_name = azurerm_resource_group.hub-vnet-rg.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}
resource "azurerm_subnet_network_security_group_association" "bastion_NSG" {
  subnet_id                 = azurerm_subnet.hub-bastion.id
  network_security_group_id = azurerm_network_security_group.bastion_NSG.id
  depends_on                = [azurerm_network_security_group.bastion_NSG]
}


//------------------------------------------------------------------------------------------------------------
# VIRTUAL MACHINE
//------------------------------------------------------------------------------------------------------------
# resource "azurerm_network_interface" "bastion-nic" {
#   name                 = "bastion-nic"
#   location             = azurerm_resource_group.hub-vnet-rg.location
#   resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
#   enable_ip_forwarding = true
#
#   ip_configuration {
#     name                          = local.prefix-hub
#     subnet_id                     = azurerm_subnet.hub-bastion.id
#     private_ip_address_allocation = "Dynamic"
#   }
#
#   tags = {
#     environment = local.prefix-hub
#   }
# }
#
#
# resource "azurerm_linux_virtual_machine" "hub-vm" {
#   name                  = "${local.prefix-hub}-bastion-vm"
#   location              = azurerm_resource_group.hub-vnet-rg.location
#   resource_group_name   = azurerm_resource_group.hub-vnet-rg.name
#   network_interface_ids = [azurerm_network_interface.bastion-nic.id]
#   size                  = "Standard_B1ls"
#
#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
#   computer_name  = "${local.prefix-hub}-vm"
#   admin_username = local.admin_username
#   admin_password = var.admin_password
#
#
#   disable_password_authentication = false
#
#
#   tags = {
#     environment = local.prefix-hub
#   }
# }
#

//------------------------------------------------------------------------------------------------------------
# Virtual Network Gateway
//------------------------------------------------------------------------------------------------------------

# resource "azurerm_public_ip" "hub-vpn-gateway1-pip" {
#   name                = "hub-vpn-gateway1-pip"
#   location            = azurerm_resource_group.hub-vnet-rg.location
#   resource_group_name = azurerm_resource_group.hub-vnet-rg.name
#
#   allocation_method = "Dynamic"
# }
#
#
# resource "azurerm_virtual_network_gateway" "hub-vnet-gateway" {
#   name                = "hub-vpn-gateway1"
#   location            = azurerm_resource_group.hub-vnet-rg.location
#   resource_group_name = azurerm_resource_group.hub-vnet-rg.name
#
#   type     = "Vpn"
#   vpn_type = "RouteBased"
#
#   active_active = false
#   enable_bgp    = false
#   sku           = "VpnGw1"
#
#   ip_configuration {
#     name                          = "vnetGatewayConfig"
#     public_ip_address_id          = azurerm_public_ip.hub-vpn-gateway1-pip.id
#     private_ip_address_allocation = "Dynamic"
#     subnet_id                     = azurerm_subnet.hub-gateway-subnet.id
#   }
#   depends_on = [azurerm_public_ip.hub-vpn-gateway1-pip]
# }
#
//------------------------------------------------------------------------------------------------------------
# AZURE FIREWALL
//------------------------------------------------------------------------------------------------------------

# resource "azurerm_public_ip" "azurefirewall_pip" {
#   name                = "fwpip"
#   location            = azurerm_resource_group.hub-vnet-rg.location
#   resource_group_name = azurerm_resource_group.hub-vnet-rg.name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }
#
# resource "azurerm_firewall" "azurefirewall" {
#   name                = "azurefw"
#   location            = azurerm_resource_group.hub-vnet-rg.location
#   resource_group_name = azurerm_resource_group.hub-vnet-rg.name
#   sku_name            = "AZFW_VNet"
#   sku_tier            = "Standard"
#
#   ip_configuration {
#     name                 = "configuration"
#     subnet_id            = azurerm_subnet.azurefirewall.id
#     public_ip_address_id = azurerm_public_ip.azurefirewall_pip.id
#   }
# }
#
# resource "azurerm_firewall_nat_rule_collection" "ssh-to-bastion" {
#   name                = "allow-ssh-to-bastion"
#   azure_firewall_name = azurerm_firewall.azurefirewall.name
#   resource_group_name = azurerm_resource_group.hub-vnet-rg.name
#   priority            = 100
#   action              = "Dnat"
#
#   rule {
#     name = "allow-ssh-to-bastion"
#
#     source_addresses = [
#       "*",
#     ]
#
#     destination_ports = [
#       "2222",
#     ]
#
#     destination_addresses = [
#       azurerm_public_ip.azurefirewall_pip.ip_address
#     ]
#
#     translated_port = 22
#
#     translated_address = "10.0.1.4"
#
#     protocols = [
#       "TCP",
#     ]
#   }
# }
#
#
//------------------------------------------------------------------------------------------------------------
# ROUTE TABLE
//------------------------------------------------------------------------------------------------------------
# resource "azurerm_route_table" "hub-route-table" {
#   name                          = "hub-route-table"
#   location                      = azurerm_resource_group.hub-vnet-rg.location
#   resource_group_name           = azurerm_resource_group.hub-vnet-rg.name
#   disable_bgp_route_propagation = false
#
#   tags = {
#     environment = "Production"
#   }
# }
#
# resource "azurerm_subnet_route_table_association" "bastion-host-route" {
#   subnet_id      = azurerm_subnet.hub-bastion.id
#   route_table_id = azurerm_route_table.hub-route-table.id
# }
#
# resource "azurerm_route" "bastion_to_firewall" {
#   name                   = "bastion-towards-firewall"
#   resource_group_name    = azurerm_resource_group.hub-vnet-rg.name
#   route_table_name       = azurerm_route_table.hub-route-table.name
#   address_prefix         = "0.0.0.0/0"
#   next_hop_type          = "VirtualAppliance"
#   next_hop_in_ip_address = "10.0.0.4"
# }
