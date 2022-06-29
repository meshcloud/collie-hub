terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.5.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.18.0"
    }
  }
}

data "azurerm_management_group" "root" {
  name = var.aad_tenant_id
}

resource "azurerm_role_definition" "cloudfoundation_deploy" {
  name        = var.service_principal_name
  scope       = data.azurerm_management_group.root.id
  description = "Permissions required to deploy the cloudfoundation (not operate it)"

  permissions {
    actions = [
      # Assigning Users
      "Microsoft.Authorization/permissions/read",
      "Microsoft.Authorization/roleAssignments/*",
      "Microsoft.Authorization/roleDefinitions/read",

      # Creating and assigning policies
      "Microsoft.Authorization/policyDefinitions/*",
      "Microsoft.Authorization/policyAssignments/*",

      # Assigning Blueprints
      "Microsoft.Resources/deployments/*",
      "Microsoft.Blueprint/blueprintAssignments/*",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/deployments/*",

      # Fetching Blueprints
      "Microsoft.Management/managementGroups/read",
      "Microsoft.Management/managementGroups/descendants/read",

      # Creating management groups
      "Microsoft.Management/managementGroups/write",

      # Permissions for reading and writing tags
      "Microsoft.Resources/tags/write",

      # Permission we need to activate/register required Resource Providers
      "*/register/action"
    ]
  }

  assignable_scopes = [
    data.azurerm_management_group.root.id
  ]
}

data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  application_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
}

resource "azuread_application" "cloudfoundation_deploy" {
  display_name = var.service_principal_name

  web {
    implicit_grant {
      access_token_issuance_enabled = false
    }
  }
  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph

    resource_access {
      id   = data.azuread_service_principal.msgraph.app_role_ids["Directory.Read.All"]
      type = "Role"
    }

    resource_access {
      id   = data.azuread_service_principal.msgraph.app_role_ids["AppRoleAssignment.ReadWrite.All"]
      type = "Role"
    }
  }

  # NOTE: currently it is not possible to automate the "Grant admin consent button"
  # https://github.com/terraform-providers/terraform-provider-azuread/issues/33
  # As a result we have to ignore this value in terraform for now
  # In addition please keep in mind you have to grant admin consent manually
  lifecycle {
    ignore_changes = [
      app_role
    ]
  }
}

resource "azuread_service_principal" "cloudfoundation_deploy" {
  application_id = azuread_application.cloudfoundation_deploy.application_id
  # The following tags are needed to create an Enterprise Application
  # See https://github.com/hashicorp/terraform-provider-azuread/issues/7#issuecomment-529597534
  tags = [
    "WindowsAzureActiveDirectoryIntegratedApp",
  ]
}

resource "azurerm_role_assignment" "cloudfoundation_deploy" {
  scope              = data.azurerm_management_group.root.id
  role_definition_id = azurerm_role_definition.cloudfoundation_deploy.role_definition_resource_id
  principal_id       = azuread_service_principal.cloudfoundation_deploy.id
}

resource "azuread_app_role_assignment" "cloudfoundation_deploy-directory" {
  app_role_id         = data.azuread_service_principal.msgraph.app_role_ids["Directory.Read.All"]
  principal_object_id = azuread_service_principal.cloudfoundation_deploy.object_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}

resource "azuread_app_role_assignment" "cloudfoundation_deploy-approle" {
  app_role_id         = data.azuread_service_principal.msgraph.app_role_ids["AppRoleAssignment.ReadWrite.All"]
  principal_object_id = azuread_service_principal.cloudfoundation_deploy.object_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}


// todo: this needs better handling with rotation
resource "azuread_service_principal_password" "cloudfoundation_deploy" {
  service_principal_id = azuread_service_principal.cloudfoundation_deploy.id
  end_date             = "2999-01-01T01:02:03Z" # no expiry, 
}
