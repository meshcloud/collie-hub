variable "provider_tf_config_path" {
  type = string
}
variable "deployment_scope" {
  type        = string
  description = "The scope where this service principal have access on. Usually in the format of '/providers/Microsoft.Management/managementGroups/0000-0000-0000'"
}

data "azurerm_subscription" "current" {
}

//---------------------------------------------------------------------------
// Create New application in Microsoft Entra ID
//---------------------------------------------------------------------------
resource "azuread_application" "building_blocks" {
  display_name = "building_blocks.standard-vnet"

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
  scope              = var.deployment_scope
  role_definition_id = data.azurerm_role_definition.builtin.id
  principal_id       = azuread_service_principal.building_blocks_spn.id
}


output "provider_tf" {

  description = "Generates a config.tf that can be dropped into meshStack's BuildingBlockDefinition as an encrypted file input to configure this building block."
  sensitive   = true
  value       = <<EOF
    provider "azurerm" {
     features {}
    client_id       = "${azuread_application.building_blocks.client_id}"
    client_secret   = "${azuread_application_password.building_blocks_application_pw.value}"
    tenant_id       = "${data.azurerm_subscription.current.tenant_id}"
    }
EOF
}

resource "local_file" "provider" {
  filename = var.provider_tf_config_path
  content  = <<-EOT
    provider "azurerm" {
     features {}
    client_id       = "${azuread_application.building_blocks.client_id}"
    client_secret   = "${azuread_application_password.building_blocks_application_pw.value}"
    tenant_id       = "${data.azurerm_subscription.current.tenant_id}"
    }
EOT
}

