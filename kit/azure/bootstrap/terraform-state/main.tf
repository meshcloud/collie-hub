resource "azurecaf_name" "cafrandom_rg" {
  name          = var.resources_cloudfoundation
  resource_type = "azurerm_resource_group"
  prefixes      = ["tfstate"]
  random_length = 3
}
resource "azurecaf_name" "cafrandom_st" {
  name          = var.resources_cloudfoundation
  resource_type = "azurerm_storage_account"
  prefixes      = ["tfstate"]
  random_length = 3
}

resource "azurerm_resource_group" "tfstates" {
  name     = azurecaf_name.cafrandom_rg.result
  location = var.location
}

resource "azurerm_storage_account" "tfstates" {
  name                      = azurecaf_name.cafrandom_st.result
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
  filename = var.terraform_state_config_file_path
  content  = <<-EOT
    storage_account_name: ${azurecaf_name.cafrandom_st.result}
    container_name: ${azurerm_storage_container.tfstates.name}
    location: ${azurerm_storage_account.tfstates.location}
    resource_group_name: ${azurecaf_name.cafrandom_rg.result}

  EOT
}
