variable "storage_account_resource_id" {
  type        = string
  description = "This is the ID of the storage account resource and it retrievable via panel. It is in the format of '/subscription/<sub_id>/resourcegroups/<rg_name>/..."
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

output "backend_tf" {
  sensitive   = true
  description = "Generates a config.tf that can be dropped into meshStack's BuildingBlockDefinition as an encrypted file input to configure this building block."
  value       = <<EOF
terraform {
  backend "azurerm" {
    tenant_id            = "${data.azurerm_subscription.sta_subscription.tenant_id}"
    subscription_id      = "${local.sta_subscription_id}"
    resource_group_name  = "${local.sta_rg_name}"
    storage_account_name = "${local.sta_name}"
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
    tenant_id            = "${data.azurerm_subscription.sta_subscription.tenant_id}"
    subscription_id      = "${local.sta_subscription_id}"
    resource_group_name  = "${local.sta_rg_name}"
    storage_account_name = "${local.sta_name}"
    container_name       = "tfstates"
    key                  = "building-block-standard-vnet"
  }
}
EOT
}
