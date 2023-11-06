locals {
  storage_account_name     = "storagetfstates"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "GRS"
  soft_delete_retention    = null
  container_name           = "tfstates"
  container_access_type    = "blob"
  tags = {
    environment = "dev"
  }
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "westeurope"
}

resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}

data "azurerm_subscription" "current" {
}
# Resource-1 Resource Group
resource "azurerm_resource_group" "rg_storage_account" {
  name     = var.resource_group_name
  location = var.location
}

# Resource-2 Storage account
resource "azurerm_storage_account" "storage" {
  name                      = "${local.storage_account_name}${random_string.unique.id}"
  resource_group_name       = azurerm_resource_group.rg_storage_account.name
  location                  = azurerm_resource_group.rg_storage_account.location
  account_kind              = local.account_kind
  account_tier              = local.account_tier
  account_replication_type  = local.account_replication_type
  access_tier               = local.access_tier
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  blob_properties {
    delete_retention_policy {
      days = local.soft_delete_retention
    }
  }
  tags = local.tags
}

# Resource-3 Storage account's container
resource "azurerm_storage_container" "container" {
  name                  = local.container_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = local.container_access_type
}

output "backend_tf" {
  sensitive   = true
  description = "Generates a config.tf that can be dropped into meshStack's BuildingBlockDefinition as an encrypted file input to configure this building block."
  value       = <<EOF
terraform {
  backend "azurerm" {
    tenant_id            = "${data.azurerm_subscription.current.tenant_id}"
    subscription_id      = "${data.azurerm_subscription.current.subscription_id}"
    resource_group_name  = "${azurerm_resource_group.rg_storage_account.name}"
    storage_account_name = "${azurerm_storage_account.storage.name}"
    container_name       = "tfstates"
    key                  = "building-block-standard-vnet"
  }
}
EOF
}

resource "local_file" "backend" {
  filename = "./outputs/generated-backend.tf"
  content  = <<-EOT
terraform {
  backend "azurerm" {
    tenant_id            = "${data.azurerm_subscription.current.tenant_id}"
    subscription_id      = "${data.azurerm_subscription.current.subscription_id}"
    resource_group_name  = "${azurerm_resource_group.rg_storage_account.name}"
    storage_account_name = "${azurerm_storage_account.storage.name}"
    container_name       = "tfstates"
    key                  = "building-block-standard-vnet"
  }
}
EOT
}
