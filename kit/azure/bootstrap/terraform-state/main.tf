resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstates" {
  name     = var.resource_group_tfstate
  location = var.location
}

resource "azurerm_storage_account" "tfstates" {
  name                      = "tfstates${random_string.resource_code.result}"
  resource_group_name       = azurerm_resource_group.tfstates.name
  location                  = azurerm_resource_group.tfstates.location
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  shared_access_key_enabled = false
}

resource "azurerm_storage_container" "tfstates" {
  name                  = "tfstates"
  storage_account_name  = azurerm_storage_account.tfstates.name
  container_access_type = "blob"
}

resource "local_file" "tfstates_yaml" {
  filename = var.file_path
  content  = <<-EOT
    storage_account_name: ${azurerm_storage_account.tfstates.name}
    container_name: ${azurerm_storage_container.tfstates.name}
    resource_group_name: ${azurerm_resource_group.tfstates.name}

  EOT
}
