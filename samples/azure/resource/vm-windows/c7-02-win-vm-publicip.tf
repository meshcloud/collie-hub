# Resource-1: Create Public IP Address
resource "azurerm_public_ip" "win_vm_publicip" {
  name = "${local.resource_name_prefix}-win-vm-publicip"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Dynamic"
  sku = "Basic"
  domain_name_label = "win-vm-${random_string.myrandom.id}"
}

