# configure our logging subscription
data "azurerm_subscription" "current" {
}

resource "azurerm_role_assignment" "terraform_state" {
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_service_principal.starterkit.object_id
  scope                = azurerm_storage_container.tfstates.resource_manager_id
}

# DESIGN: we don't want to permanently hold permissions on all subscriptions via the MG hierarchy
# this is mean to work in conjunction with the conditional assignment below
resource "azurerm_role_definition" "starterkit_access" {
  name              = "${azuread_service_principal.starterkit.display_name}-access"
  description       = "Allow self-assignment of a role in order access an application team's subscription for deployment"
  scope             = var.scope
  assignable_scopes = [var.scope]

  permissions {
    actions = [
      "Microsoft.Authorization/roleAssignments/*"
    ]
  }
}

resource "azurerm_role_definition" "starterkit_deploy" {
  name        = "${azuread_service_principal.starterkit.display_name}-deploy"
  description = "Enables deployment of starter kits to applicaiton team subscriptions"
  scope       = var.scope

  permissions {
    actions = [
      "Microsoft.Authorization/*/read",
      "Microsoft.Authorization/roleDefinitions/*",
      "Microsoft.Authorization/roleAssignments/*",
      "Microsoft.Resources/subscriptions/resourceGroups/*",
      "Microsoft.Storage/storageAccounts/*",
      "Microsoft.ManagedIdentity/*"
    ]
  }
}

resource "azurerm_role_assignment" "starterkit_access" {
  role_definition_id = azurerm_role_definition.starterkit_access.role_definition_resource_id

  description  = "Allow the ${azuread_service_principal.starterkit.display_name} SPN to grant itself permissions on an application team's subscription to deploy a starterkit building block."
  principal_id = azuread_service_principal.starterkit.object_id
  scope        = var.scope

  condition_version = "2.0"

  # what this does: if the request is  not a write and not a delete, pass, else check that it only contains the expected role definition id

  condition = <<-EOT
(
  !(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})
  AND
  !(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})
)
OR
(
  @Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAnyValues:GuidEquals {${azurerm_role_definition.starterkit_deploy.role_definition_id}}
  AND
  @Request[Microsoft.Authorization/roleAssignments:PrincipalId] ForAnyOfAnyValues:GuidEquals {${azuread_service_principal.starterkit.object_id}}
)
EOT
}