
# Resource: Azure windows Virtual Machine
resource "azurerm_windows_virtual_machine" "win_vm" {
  name                  = "${local.resource_name_prefix}-collie-windows"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_B2s"
  admin_username        = "meshadmin"
  admin_password        = azurerm_key_vault_secret.winvmpassword.value
  network_interface_ids = [azurerm_network_interface.win_vm_nic.id]
  computer_name         = "collie-windows"
  os_disk {
    name                 = "${local.resource_name_prefix}-win-vm"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-21h2-pro-g2"
    version   = "latest"
  }

  # provisioner "remote-exec" {
  #   connection {
  #     type     = "winrm"
  #     user     = "meshadmin"
  #     password = azurerm_key_vault_secret.winvmpassword.value
  #   }

  #   inline = [
  #     #"powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
  #   ]
  # }
}

# Configure autoshutdown everyday
resource "azurerm_dev_test_global_vm_shutdown_schedule" "win_vm_shutdown_schedule" {
  virtual_machine_id = azurerm_windows_virtual_machine.win_vm.id
  location           = azurerm_resource_group.rg.location
  enabled            = true

  daily_recurrence_time = "2000"
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled         = false
    time_in_minutes = "60"
    webhook_url     = "https://sample-webhook-url.example.com"
  }
}