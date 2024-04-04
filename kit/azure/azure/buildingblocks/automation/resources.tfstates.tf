resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstates" {
  name     = "buildingblocks-tfstates"
  location = var.location
}

resource "azurerm_storage_account" "tfstates" {
  name                     = "tfstates${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.tfstates.name
  location                 = azurerm_resource_group.tfstates.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false

  blob_properties {
    versioning_enabled = true
    # we simply enable versioning to keep _every_ version without any expiration, you should reconsider this at scale
  }
}

resource "azurerm_storage_container" "tfstates" {
  name                  = "tfstates"
  storage_account_name  = azurerm_storage_account.tfstates.name
  container_access_type = "private"
}

