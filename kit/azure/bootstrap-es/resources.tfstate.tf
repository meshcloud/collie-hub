# Place your module's terraform resources here as usual.
# Note that you should typically not put a terraform{} block into cloud foundation kit modules,
# these will be provided by the platform implementations using this kit module.

resource "azurerm_resource_group" "tfstate" {
  name     = var.storage_rg_name
  location = var.tfstate_location

  tags = {
    created_by = "LZCK"
  }
}

resource "azurerm_storage_account" "tfstate" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    created_by = "LZCK"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
}

resource "azurerm_role_assignment" "tfstate_blob" {
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_group.platform_engineers.object_id
  scope                = azurerm_storage_container.tfstate.resource_manager_id
}

resource "azurerm_role_assignment" "tfstate_storage_account" {
  role_definition_name = "Storage Account Key Operator Service Role"
  principal_id         = azuread_group.platform_engineers.object_id
  scope                = azurerm_storage_account.tfstate.id
}
