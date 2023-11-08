variable "storage_account_resource_id" {
  type        = string
  description = "This is the ID of the storage account resource and it retrievable via panel. It is in the format of '/subscription/<sub_id>/resourcegroups/<rg_name>/..."
}

variable "backend_tf_config_path" {
  type = string
}

locals {
  sta_resource_id     = split("/", "${var.storage_account_resource_id}")
  sta_subscription_id = local.sta_resource_id[2]
  sta_rg_name         = local.sta_resource_id[4]
  sta_name            = local.sta_resource_id[8]
}

data "azurerm_subscription" "sta_subscription" {
  subscription_id = local.sta_subscription_id
}

data "azurerm_storage_account" "tfstates" {
  name                = local.sta_name
  resource_group_name = local.sta_rg_name
}

# resource "azurerm_storage_container" "tfstates" {
#   name = "tfstates-standard-vnet"
#   storage_account_name = data.azurerm_storage_account.tfstates.name
#   container_access_type = "blob"
# }

resource "azapi_resource" "container" {
  type      = "Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01"
  name      = "tfstates-standard-vnet"
  parent_id = "${data.azurerm_storage_account.tfstates.id}/blobServices/default"
  body = jsonencode({
    properties = {
      defaultEncryptionScope      = "$account-encryption-key"
      denyEncryptionScopeOverride = true
      immutableStorageWithVersioning = {
        enabled = false
      }
      metadata     = {}
      publicAccess = "Blob"
    }
  })
}
output "backend_tf" {
  sensitive   = true
  description = "Generates a config.tf that can be dropped into meshStack's BuildingBlock Definition as an encrypted file input to configure this building block."
  value       = <<EOF
terraform {
  backend "azurerm" {
    tenant_id            = "${data.azurerm_subscription.sta_subscription.tenant_id}"
    subscription_id      = "${local.sta_subscription_id}"
    resource_group_name  = "${local.sta_rg_name}"
    storage_account_name = "${local.sta_name}"
    container_name       = "${azapi_resource.container.name}"
    key                  = "building-block-standard-vnet"
  }
}
EOF
}

resource "local_file" "backend" {
  filename = var.backend_tf_config_path
  content  = <<-EOT
terraform {
  backend "azurerm" {
    tenant_id            = "${data.azurerm_subscription.sta_subscription.tenant_id}"
    subscription_id      = "${local.sta_subscription_id}"
    resource_group_name  = "${local.sta_rg_name}"
    storage_account_name = "${local.sta_name}"
    container_name       = "${azapi_resource.container.name}"
    key                  = "building-block-standard-vnet"
  }
}
EOT
}

