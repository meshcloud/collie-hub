resource "azuread_group" "platform_engineers" {
  display_name     = var.platform_engineers_group
  description      = "Privileged Cloud Foundation group. Members have full access to deploy cloud foundation infrastructure and landing zones."
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
  members          = toset(data.azuread_users.platform_engineers_members.object_ids)
}

resource "azurerm_role_definition" "cloudfoundation_deploy" {
  name        = var.platform_engineers_group
  scope       = data.azurerm_management_group.root.id
  description = "Permissions required to deploy the cloudfoundation"

  permissions {
    actions = [
      # Assigning Users
      "Microsoft.Authorization/permissions/read",
      "Microsoft.Authorization/roleAssignments/*",
      "Microsoft.Authorization/roleDefinitions/*",

      # Creating and assigning policies
      "Microsoft.Authorization/policyDefinitions/*",
      "Microsoft.Authorization/policyAssignments/*",
      "Microsoft.Authorization/policySetDefinitions/*",

      # Read Resources in subscriptions
      "Microsoft.Resources/subscriptions/resourceGroups/read",

      # Creating management groups
      "Microsoft.Management/managementGroups/read",
      "Microsoft.Management/managementGroups/write",
      "Microsoft.Management/managementGroups/descendants/read",

      # Permissions to move subscriptions between management groups
      "Microsoft.Management/managementgroups/subscriptions/delete",
      "Microsoft.Management/managementgroups/subscriptions/write",

      # Permissions for reading and writing tags
      "Microsoft.Resources/tags/*",

      # Permission we need to activate/register required Resource Providers
      "*/register/action",

      # Deployment Permissions
      # Permissions to create storage account and containers
      "Microsoft.Storage/storageAccounts/*",
      "Microsoft.Storage/storageAccounts/blobServices/containers/*"
    ]
  }

  assignable_scopes = [
    data.azurerm_management_group.root.id
  ]
}

data "azuread_application_published_app_ids" "well_known" {}

resource "azurerm_role_assignment" "cloudfoundation_deploy" {
  scope              = data.azurerm_management_group.root.id
  role_definition_id = azurerm_role_definition.cloudfoundation_deploy.role_definition_resource_id
  principal_id       = azuread_group.platform_engineers.id
}
