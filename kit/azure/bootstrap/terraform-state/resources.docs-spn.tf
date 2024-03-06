# allow reading terraform state

# important caveat: the current, simplified design of the bootstrap module means that this the docs UAMI can read
# the deploy SPN client id/secret and use this to execute the other modules. This is an important shortcomming because
# it means that even though the UAMI is read-only, it can read-write execute non-bootstrap terraform modules
resource "azurerm_user_assigned_identity" "docs" {
  count               = var.uami_documentation_spn ? 1 : 0
  location            = azurerm_resource_group.tfstates.location
  name                = var.uami_documentation_name
  resource_group_name = azurerm_resource_group.tfstates.name
}

resource "azurerm_role_assignment" "docs_tfstate" {
  count = var.uami_documentation_spn ? 1 : 0

  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.docs[0].principal_id
  scope                = azurerm_storage_container.tfstates.resource_manager_id
}

# see https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure#adding-the-federated-credentials-to-azure
resource "azurerm_federated_identity_credential" "docs" {
  count = var.uami_documentation_spn ? 1 : 0

  parent_id           = azurerm_user_assigned_identity.docs[0].id
  resource_group_name = azurerm_resource_group.tfstates.name
  name                = var.uami_documentation_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.uami_documentation_issuer
  # note: it seems wildcards are not supported yet, see https://github.com/Azure/azure-workload-identity/issues/373
  subject = var.uami_documentation_subject
}
