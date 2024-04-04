data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_management_group" "parent" {
  name = var.parent_management_group_name
}

module "terraform_state" {
  source                           = "./terraform-state"
  location                         = var.terraform_state_storage.location
  cloudfoundation                  = var.terraform_state_storage.name
  terraform_state_config_file_path = var.terraform_state_storage.config_file_path
  resource_group_name              = var.terraform_state_storage.resource_group_name
}

moved {
  from = module.terraform_state[0]
  to   = module.terraform_state
}

# Set permissions on the blob store
resource "azurerm_role_assignment" "tfstates_engineers" {
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_group.platform_engineers.object_id
  scope                = module.terraform_state.container_id
}

resource "azurerm_role_definition" "cloudfoundation_deploy" {
  name        = var.platform_engineers_group
  scope       = data.azurerm_management_group.parent.id
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

      # rename subscriptions",
      "Microsoft.Subscription/rename/action",
      "Microsoft.Subscription/aliases/read",
      "Microsoft.Subscription/aliases/write",
      "Microsoft.Subscription/aliases/delete",

      # Permission we need to activate/register required Resource Providers
      "*/register/action"
    ]
  }

  assignable_scopes = [
    data.azurerm_management_group.parent.id
  ]
}

resource "azurerm_role_assignment" "cloudfoundation_deploy" {
  scope              = data.azurerm_management_group.parent.id
  role_definition_id = azurerm_role_definition.cloudfoundation_deploy.role_definition_resource_id
  principal_id       = azuread_group.platform_engineers.id
}