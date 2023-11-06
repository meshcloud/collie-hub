//---------------------------------------------------------------------------
// ====== Using existing Service Principal ========
//---------------------------------------------------------------------------

data "azurerm_subscription" "current" {

}

variable "existing_application_id" {
  type        = string
  description = "Application (client) ID of the Enterprise application"
}


data "azuread_service_principal" "existing_spn" {
  client_id = var.existing_application_id
}
data "azuread_application" "existing_app" {
  client_id = data.azuread_service_principal.existing_spn.client_id
}

resource "time_rotating" "building_blocks_secret_rotation" {
  rotation_days = 365
}

resource "azuread_application_password" "existing_application_pw" {
  application_id = "/applications/${data.azuread_application.existing_app.id}"
  rotate_when_changed = {
    rotation = time_rotating.building_blocks_secret_rotation.id
  }
}

output "provider_block" {

  description = "Generates a config.tf that can be dropped into meshStack's BuildingBlockDefinition as an encrypted file input to configure this building block."
  value       = <<EOF
    provider "azurerm" {
     features {}
    client_id       = "${data.azuread_service_principal.existing_spn.client_id}"
    client_secret   = "${azuread_application_password.existing_application_pw.value}
    tenant_id       = "${data.azurerm_subscription.current.tenant_id}"
    subscription_id = "${data.azurerm_subscription.current.subscription_id}"
    }
EOF
}

resource "local_file" "provider" {
  filename = "./outputs/generated-provider.tf"
  content  = <<-EOT
    provider "azurerm" {
     features {}
    client_id       = "${data.azuread_service_principal.existing_spn.client_id}"
    client_secret   = "${azuread_application_password.existing_application_pw.value}"
    tenant_id       = "${data.azurerm_subscription.current.tenant_id}"
    subscription_id = "${data.azurerm_subscription.current.subscription_id}"
    }
EOT
}
