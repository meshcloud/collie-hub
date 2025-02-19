data "azurerm_subscription" "current" {}

resource "azurerm_role_assignment" "tfstates_engineers" {
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_service_principal.buildingblock.object_id
  scope                = azurerm_storage_container.tfstates.resource_manager_id
}

# DESIGN: the BB Automation SPN needs some default permissions in order to be able to deploy building blocks that
# require access to deploy resources in target subscriptions.
#
# We therefore grant two very powerful permissions: manage all RoleAssignments and manage all ResourceGroups.
# However, we take great care to limit those permissions via policy so that the principal can only use them on
# specifically whitelisted resource groups.

data "azurerm_key_vault" "cf_key_vault" {
  name                = var.key_vault.name
  resource_group_name = var.key_vault.resource_group_name
}

data "azurerm_role_definition" "keyvault_administrator" {
  name = "Key Vault Administrator"
}

resource "azurerm_role_assignment" "keyvault_administrator" {
  scope                = data.azurerm_key_vault.cf_key_vault.id
  role_definition_name = data.azurerm_role_definition.keyvault_administrator.name
  principal_id         = azuread_service_principal.buildingblock.object_id
}

locals {
  managedResourceGroups = ["connectivity"]
}

resource "azurerm_role_definition" "buildingblock_plan" {
  name        = "${var.service_principal_name}-plan"
  description = "Enables read only access in order to plan building block deployments"
  scope       = var.scope

  permissions {
    actions = [
      # Reading management groups
      "Microsoft.Management/managementGroups/read",
      "Microsoft.Management/managementGroups/descendants/read",
      "Microsoft.Management/managementgroups/subscriptions/read",
      "Microsoft.Resources/tags/read",

      # restricted via policy, see below so we can only add permissions to the SPN on whitelisted resource groups
      "Microsoft.Authorization/roleAssignments/*",

      # These are very powerful permissions, i.e. the SPN can technically delete every resource group(!) and thus transitively every resource(!)
      # Unfortunately Azure does not make it possible right now to restrict this permission to specific management groups
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/subscriptions/resourceGroups/write",
      "Microsoft.Resources/subscriptions/resourceGroups/delete",

      # Permission we need to activate/register required Resource Providers
      "Microsoft.Resources/subscriptions/providers/read",
      "*/register/action",
    ]
  }
}

resource "azurerm_role_assignment" "buildingblock_deploy" {
  role_definition_id = azurerm_role_definition.buildingblock_plan.role_definition_resource_id
  principal_id       = azuread_service_principal.buildingblock.object_id
  scope              = var.scope

}

# Note: this has to be an Azure policy, Azure ABAC condition on the role assignment above does not yet support
# "@Request[Microsoft.Authorization/roleAssignments:Scope]"
resource "azurerm_policy_definition" "buildingblock_access" {
  name         = "${var.service_principal_name}_rbac"
  display_name = "Restrict ${var.service_principal_name} role assignments"
  description  = "Restrict building block automations to manage role assignments only on exclusively owned resource groups"
  policy_type  = "Custom"
  mode         = "All"

  management_group_id = var.scope

  parameters = <<EOF
  {
    "managedResourceGroups": {
      "type": "Array",
      "metadata": {
          "displayName": "Managed Resource Group Names",
          "description": "Name of the resource groups exclusively managed by this automation"
      }
    },
    "principalId": {
      "type": "String",
      "metadata": {
          "displayName": "Principal Id",
          "description": "Id of the automation principal allowed to access the managedResourceGroups"
      }
    }
  }
  EOF

  policy_rule = <<EOF
  {
    "if": {
      "allOf": [
        {
          "equals": "Microsoft.Authorization/roleAssignments",
          "field": "type"
        },
        {
          "field": "Microsoft.Authorization/roleAssignments/principalId",
          "equals": "[parameters('principalId')]"
        },
        {
          "value": "[resourceGroup().name]",
          "notIn": "[parameters('managedResourceGroups')]"
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  }
  EOF
}

resource "azurerm_management_group_policy_assignment" "buildingblock_access" {
  name                 = "restrict-bb-rbac" # we can only have 24 characters in the name...
  display_name         = azurerm_policy_definition.buildingblock_access.display_name
  description          = azurerm_policy_definition.buildingblock_access.description
  policy_definition_id = azurerm_policy_definition.buildingblock_access.id
  management_group_id  = var.scope

  parameters = jsonencode({
    principalId           = { value = azuread_service_principal.buildingblock.object_id }
    managedResourceGroups = { value = local.managedResourceGroups }
  })
}
