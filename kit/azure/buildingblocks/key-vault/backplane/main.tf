resource "azurerm_role_definition" "buildingblock_deploy" {
  name        = "${var.name}-deploy"
  description = "Enables deployment of the ${var.name} building block to subscriptions"
  scope       = var.scope
  permissions {
    actions = [
      "Microsoft.KeyVault/vaults/write",
      "Microsoft.KeyVault/vaults/read",
      "Microsoft.KeyVault/vaults/delete",
      "Microsoft.KeyVault/locations/deletedVaults/read",
      "Microsoft.Authorization/roleAssignments/write",
      "Microsoft.Authorization/roleAssignments/delete",
      "Microsoft.Authorization/roleAssignments/read"
    ]
  }
}

resource "azurerm_role_assignment" "buildingblock_deploy" {
  for_each = var.principal_ids

  role_definition_id = azurerm_role_definition.buildingblock_deploy.role_definition_resource_id
  principal_id       = each.value
  scope              = var.scope
}

resource "azuread_directory_role" "directory_readers" {
  display_name = "Directory Readers"
}

resource "azuread_directory_role_assignment" "directory_readers" {
  for_each            = var.principal_ids
  role_id             = azuread_directory_role.directory_readers.template_id
  principal_object_id = each.value
}
