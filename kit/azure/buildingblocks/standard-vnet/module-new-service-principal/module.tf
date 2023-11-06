locals {
  scope                         = var.deployment_scope
  service_principal_name_suffix = var.spn_suffix
  deployment_scope              = var.deployment_scope
}

variable "deployment_scope" {
  type        = string
  description = "The scope where this service principal have access on. Usually in the format of '/providers/Microsoft.Management/managementGroups/0000-0000-0000'"
}

variable "spn_suffix" {
  type        = string
  description = "suffix for the SPN's name. The format is 'building_blocks.<SUFFIX>'"
}


data "azurerm_subscription" "current" {

}
//---------------------------------------------------------------------------
// Queries Entra ID for information about well-known application IDs.
// Retrieve details about the service principal
//---------------------------------------------------------------------------

data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
}

//---------------------------------------------------------------------------
// Create New application in Microsoft Entra ID
//---------------------------------------------------------------------------
resource "azuread_application" "building_blocks" {
  display_name = "building_blocks.${local.service_principal_name_suffix}"

  feature_tags {
    enterprise = true
  }
  web {
    implicit_grant {
      access_token_issuance_enabled = false
    }
  }

  lifecycle {
    ignore_changes = [
      app_role
    ]
  }

  logo_image = filebase64("./icon.png")

}

//---------------------------------------------------------------------------
// Create new client secret and associate it with building_blocks_application application
//---------------------------------------------------------------------------
resource "time_rotating" "building_blocks_secret_rotation" {
  rotation_days = 365
}
resource "azuread_application_password" "building_blocks_application_pw" {
  application_id = azuread_application.building_blocks.id
  rotate_when_changed = {
    rotation = time_rotating.building_blocks_secret_rotation.id
  }
}

//---------------------------------------------------------------------------
// Create new Enterprise Application and associate it with building_blocks_application application
//---------------------------------------------------------------------------
resource "azuread_service_principal" "building_blocks_spn" {
  client_id = azuread_application.building_blocks.client_id

  feature_tags {
    enterprise            = true
    custom_single_sign_on = true
  }
}


//---------------------------------------------------------------------------
// Assign the created ARM role to the Enterprise application
//---------------------------------------------------------------------------
data "azurerm_role_definition" "builtin" {
  name = "Contributor"
}

resource "azurerm_role_assignment" "building_blocks" {
  scope              = local.scope
  role_definition_id = data.azurerm_role_definition.builtin.id
  principal_id       = azuread_service_principal.building_blocks_spn.id
}

output "provider_block" {
  description = "Generates a config.tf that can be dropped into meshStack's BuildingBlock Definition as an encrypted file input to configure this building block."
  value       = <<EOF
    provider "azurerm" {
     features {}
    client_id       = "${azuread_service_principal.building_blocks_spn.client_id}"
    client_secret   = "${azuread_application_password.building_blocks_application_pw.value}"
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
    client_id       = "${azuread_service_principal.building_blocks_spn.client_id}"
    client_secret   = "${azuread_application_password.building_blocks_application_pw.value}"
    tenant_id       = "${data.azurerm_subscription.current.tenant_id}"
    subscription_id = "${data.azurerm_subscription.current.subscription_id}"
    }
EOT
}
