data "azurerm_subscription" "subscription" {
  subscription_id = var.subscription_id
}

// attempt to find the "project-admin" group based on the naming convention configured in meshStack. Adjust this to your needs.
data "azuread_groups" "users_groups" {
  display_names = ["${var.workspace_identifier}.${var.project_identifier}-admin"]
}

data "azurerm_role_definition" "owner" {
  name = "Owner"
}

resource "azurerm_role_assignment" "uam" {
  for_each = toset(data.azuread_groups.users_groups.object_ids)

  scope                = data.azurerm_subscription.subscription.id
  role_definition_name = "User Access Administrator"
  principal_id         = each.key

  # example: allow all assignments except owner role
  condition_version = "2.0"
  condition         = <<EOF
    (
      (
        !(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})
      )
      OR
      (
        @Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {${basename(data.azurerm_role_definition.owner.role_definition_id)}}
      )
    )
    AND
    (
      (
        !(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})
      )
      OR
      (
        @Resource[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {${basename(data.azurerm_role_definition.owner.role_definition_id)}}
      )
    )
  EOF
}