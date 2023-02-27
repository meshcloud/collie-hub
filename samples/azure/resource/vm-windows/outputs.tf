# Virtual Network Outputs
## Virtual Network Name
output "virtual_network_name" {
  description = "Virtual Network Name"
  value = azurerm_virtual_network.vnet.name
}
## Virtual Network ID
output "virtual_network_id" {
  description = "Virtual Network ID"
  value = azurerm_virtual_network.vnet.id
}

# Subnet Outputs (We will write for one vm subnet and rest all we will ignore for now)
## Subnet Name 
output "vm_subnet_name" {
  description = "vmTier Subnet Name"
  value = azurerm_subnet.vm_subnet.name
}

## Subnet ID 
output "vm_subnet_id" {
  description = "vm Subnet ID"
  value = azurerm_subnet.vm_subnet.id
}

# Network Security Outputs
## vm Subnet NSG Name 
output "vm_subnet_nsg_name" {
  description = "vm Subnet NSG Name"
  value = azurerm_network_security_group.vm_subnet_nsg.name
}

## vm Subnet NSG ID 
output "vm_subnet_nsg_id" {
  description = "vm Subnet NSG ID"
  value = azurerm_network_security_group.vm_subnet_nsg.id
}


## Public IP Address
output "win_vm_public_ip" {
  description = "Windows VM Public Address"
  value = azurerm_public_ip.win_vm_publicip.ip_address
}

# Network Interface Outputs
## Network Interface ID
output "win_vm_network_interface_id" {
  description = "Windows VM Network Interface ID"
  value = azurerm_network_interface.win_vm_nic.id
}
## Network Interface Private IP Addresses
output "web_linuxvm_network_interface_private_ip_addresses" {
  description = "Windows VM Private IP Addresses"
  value = [azurerm_network_interface.win_vm_nic.private_ip_addresses]
}

## Virtual Machine Public IP
output "win_vm_public_ip_address" {
  description = "Windows Virtual Machine Public IP"
  value = azurerm_windows_virtual_machine.win_vm
  sensitive = true
}


## Virtual Machine Private IP
output "win_vm_private_ip_address" {
  description = "Windows Virtual Machine Private IP"
  value = azurerm_windows_virtual_machine.win_vm.private_ip_address
}

## Virtual Machine ID
output "win_vm_virtual_machine_id" {
  description = "Windows Virtual Machine ID "
  value = azurerm_windows_virtual_machine.win_vm.id
}