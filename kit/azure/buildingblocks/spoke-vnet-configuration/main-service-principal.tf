variable "provider_tf_config_path" {
  type = string
}
variable "deployment_scope" {
  type        = string
  description = "The scope where this service principal have access on. It is recommended to use the meshcloud's management group, so the buildingblock can be re-used within any projects"
  validation {
    condition     = can(regex("/providers/Microsoft.Management/managementGroups/[^/]+", var.deployment_scope))
    error_message = "Should be in the format of '/providers/Microsoft.Management/managementGroups/XXXX"
  }
}

data "azurerm_subscription" "current" {
}

//---------------------------------------------------------------------------
// Create New application in Microsoft Entra ID
//---------------------------------------------------------------------------
resource "azuread_application" "building_blocks" {
  display_name = "building_blocks.spoke-vnet"

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
    enterprise = true
  }
}


//---------------------------------------------------------------------------
// Assign the created ARM role to the Enterprise application
//---------------------------------------------------------------------------
data "azurerm_role_definition" "builtin" {
  name = "Contributor"
}

resource "azurerm_role_definition" "resource_group_contributor" {
  name        = "resource_group_contributor-role"
  scope       = var.deployment_scope
  description = "A custom role that allows to manage resource groups. Used by Cloud Foundation automation."

  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/write",
      "Microsoft.Resources/subscriptions/resourceGroups/delete",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
    ]
  }

  assignable_scopes = [
    var.deployment_scope
  ]
}
resource "azurerm_role_assignment" "resource_group_contributor" {
  scope              = var.deployment_scope
  role_definition_id = azurerm_role_definition.resource_group_contributor.role_definition_resource_id
  principal_id       = azuread_service_principal.building_blocks_spn.id
}
resource "azurerm_role_assignment" "networking_contributor" {
  scope                = var.deployment_scope
  role_definition_name = "Network Contributor"
  principal_id         = azuread_service_principal.building_blocks_spn.id
}

resource "azurerm_role_assignment" "building_blocks_backend" {
  scope              = azapi_resource.container.id
  role_definition_id = data.azurerm_role_definition.builtin.id
  principal_id       = azuread_service_principal.building_blocks_spn.id
}


output "provider_tf" {

  description = "Generates a config.tf that can be dropped into meshStack's BuildingBlockDefinition as an encrypted file input to configure this building block."
  sensitive   = true
  value       = <<EOF
  provider "azurerm" {
    client_id       = "${azuread_application.building_blocks.client_id}"
    client_secret   = "${azuread_application_password.building_blocks_application_pw.value}"
    tenant_id       = "${data.azurerm_subscription.current.tenant_id}"
    alias           = "spoke-provider"
    features {
      resource_group {
        prevent_deletion_if_contains_resources = true
      }
    }
  }
  provider "azurerm" {
    alias           = "hub-provider"
    # set hub_subscription_id variable in the building block definition input. It usually is separate than the subscription_id (of the spoke)
    subscription_id = var.hub_subscription_id
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
    client_id       = "${azuread_application.building_blocks.client_id}"
    client_secret   = "${azuread_application_password.building_blocks_application_pw.value}"
    tenant_id       = "${data.azurerm_subscription.current.tenant_id}"
    alias           = "spoke-provider"
    features {
      resource_group {
        prevent_deletion_if_contains_resources = true
      }
    }
  }
  provider "azurerm" {
    alias           = "hub-provider"
    # set hub_subscription_id variable in the building block definition input. It usually is separate than the subscription_id (of the spoke)
    subscription_id = var.hub_subscription_id
    features {}
    client_id       = "${azuread_application.building_blocks.client_id}"
    client_secret   = "${azuread_application_password.building_blocks_application_pw.value}"
    tenant_id       = "${data.azurerm_subscription.current.tenant_id}"
}
EOT
}
