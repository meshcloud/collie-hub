resource "azurerm_role_definition" "aviatrix_deploy" {
  name        = var.service_principal_name
  scope       = var.parent_management_group
  description = "Permissions required to deploy the Aviatrix Spoke"

  permissions {
    actions = [
      #https://docs.aviatrix.com/documentation/latest/accounts-and-users/custom-role-azure.html?expand=true
      "Microsoft.MarketplaceOrdering/offerTypes/publishers/offers/plans/agreements/*",
      "Microsoft.Compute/*/read",
      "Microsoft.Compute/availabilitySets/*",
      "Microsoft.Compute/virtualMachines/*",
      "Microsoft.Network/*/read",
      "Microsoft.Network/publicIPAddresses/*",
      "Microsoft.Network/networkInterfaces/*",
      "Microsoft.Network/networkSecurityGroups/*",
      "Microsoft.Network/loadBalancers/*",
      "Microsoft.Network/routeTables/*",
      "Microsoft.Network/virtualNetworks/*",
      "Microsoft.Storage/storageAccounts/*",
      "Microsoft.Resources/*/read",
      "Microsoft.Resourcehealth/healthevent/*",
      "Microsoft.Resources/deployments/*",
      "Microsoft.Resources/tags/*",
      "Microsoft.Resources/marketplace/purchase/action",
      "Microsoft.Resources/subscriptions/resourceGroups/*"
    ]
  }

  assignable_scopes = [
    var.parent_management_group
  ]
}

data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
}

resource "azuread_application" "aviatrix_deploy" {
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
      id   = data.azuread_service_principal.msgraph.app_role_ids["Group.ReadWrite.All"]
      type = "Role"
    }
    resource_access {
      id   = data.azuread_service_principal.msgraph.app_role_ids["AppRoleAssignment.ReadWrite.All"]
      type = "Role"
    }

    resource_access {
      id   = data.azuread_service_principal.msgraph.app_role_ids["Application.ReadWrite.All"]
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

resource "azuread_service_principal" "aviatrix_deploy" {
  client_id = azuread_application.aviatrix_deploy.client_id
  # The following tags are needed to create an Enterprise Application
  # See https://github.com/hashicorp/terraform-provider-azuread/issues/7#issuecomment-529597534
  tags = [
    "WindowsAzureActiveDirectoryIntegratedApp",
  ]
}

resource "azurerm_role_assignment" "aviatrix_deploy" {
  scope              = var.parent_management_group
  role_definition_id = azurerm_role_definition.aviatrix_deploy.role_definition_resource_id
  principal_id       = azuread_service_principal.aviatrix_deploy.object_id
}

resource "azuread_app_role_assignment" "aviatrix_deploy-directory" {
  app_role_id         = data.azuread_service_principal.msgraph.app_role_ids["Directory.Read.All"]
  principal_object_id = azuread_service_principal.aviatrix_deploy.object_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}
# This azuread_app_role_assignment is necessary if you want to manage groups through Terraform.
# Productive use in a cloud foundation should probably manage groups not via Terraform but
# via existing IAM processes, but this is a good lean start.
# resource "azuread_app_role_assignment" "aviatrix_deploy-group" {
#   app_role_id         = data.azuread_service_principal.msgraph.app_role_ids["Group.ReadWrite.All"]
#   principal_object_id = azuread_service_principal.aviatrix_deploy.object_id
#   resource_object_id  = data.azuread_service_principal.msgraph.object_id
# }

resource "azuread_app_role_assignment" "aviatrix_deploy-approle" {
  app_role_id         = data.azuread_service_principal.msgraph.app_role_ids["AppRoleAssignment.ReadWrite.All"]
  principal_object_id = azuread_service_principal.aviatrix_deploy.object_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}

# note this requires the terraform to be run regularly
resource "time_rotating" "key_rotation" {
  rotation_days = 365
}

resource "azuread_application_password" "aviatrix_deploy" {
  application_id = azuread_application.aviatrix_deploy.id
  rotate_when_changed = {
    rotation = time_rotating.key_rotation.id
  }
}
