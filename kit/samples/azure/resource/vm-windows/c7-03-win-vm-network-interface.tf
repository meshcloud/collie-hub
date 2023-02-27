# Resource-2: Create Network Interface
resource "azurerm_network_interface" "win_vm_nic" {
  name = "${local.resource_name_prefix}-win-vm-nic"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name = "win-vm-ip-1"
    subnet_id = azurerm_subnet.vm_subnet.id 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.win_vm_publicip.id
  }
}

