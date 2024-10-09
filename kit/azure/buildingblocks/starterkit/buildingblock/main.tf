data "azurerm_subscription" "current" {}
data "azuread_client_config" "current" {}

# note: it's important that all other azure resources transitively depend on this role assignment or else they will fail
resource "azurerm_role_assignment" "starterkit_deploy" {
  # since the role is defined on MG level, we need to prefix the subscription id here to make terraform happy and not plan replacements
  # see https://github.com/hashicorp/terraform-provider-azurerm/issues/19847#issuecomment-1407262429
  role_definition_id = "${data.azurerm_subscription.current.id}${local.deploy_role_definition_id}"

  description  = "Grant permissions to deploy a starterkit building block."
  principal_id = data.azuread_client_config.current.object_id
  scope        = data.azurerm_subscription.current.id
}

#
# configure developer acess
#

# note: this group is managed via meshStack and provided as part of the sandbox landing zone
data "azuread_group" "project_admins" {
  display_name = "${var.workspace_identifier}.${var.project_identifier}-admin"
}

# rationale: normal uses with "Project User" role should only deploy code via the pipeline and therefore don't need
# access to terraform state, but users wotj "Project Admin" role should be able to debug terraform issues and therefore
# work with the state directly
resource "azurerm_role_assignment" "project_admins_blobs" {
  role_definition_name = "Storage Blob Data Owner"
  description          = "Allow developer assigned the 'Project Admin' role via meshStack to work directly with terraform state"

  principal_id = data.azuread_group.project_admins.object_id
  scope        = azurerm_storage_container.tfstates.resource_manager_id
}
