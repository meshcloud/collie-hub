# todo: this could be nicer packaged as it's own submodule, so that it doesn't need all those count = ... checks

resource "azurerm_user_assigned_identity" "docs" {
  count = var.terraform_state_storage != null ? 1 : 0

  location            = var.terraform_state_storage.location
  name                = var.documentation_uami_name
  resource_group_name = module.terraform_state[0].resource_group_name
}

# see https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure#adding-the-federated-credentials-to-azure
resource "azurerm_federated_identity_credential" "docs" {
  count = var.terraform_state_storage != null ? 1 : 0

  parent_id           = azurerm_user_assigned_identity.docs[0].id
  resource_group_name = module.terraform_state[0].resource_group_name

  name     = "github-actions"
  audience = ["api://AzureADTokenExchange"]
  issuer   = "https://token.actions.githubusercontent.com"

  # note: it seems wildcards are not supported yet, see https://github.com/Azure/azure-workload-identity/issues/373
  subject = "repo:likvid-bank/likvid-cloudfoundation:environment:github-pages"
}

resource "azurerm_role_assignment" "docs_tfstate" {
  count = var.terraform_state_storage != null ? 1 : 0

  # allow reading terraform state

  # important caveat: the current, simplified design of the bootstrap module means that this the docs UAMI can read
  # the deploy SPN client id/secret and use this to execute the other modules. This is an important shortcomming because
  # it means that even though the UAMI is read-only, it can read-write execute non-bootstrap terraform modules
  role_definition_name = "Storage Blob Data Reader"

  principal_id = azurerm_user_assigned_identity.docs[0].principal_id
  scope        = module.terraform_state[0].container_id
}

output "documentation_uami_client_id" {
  value = azurerm_user_assigned_identity.docs[0].client_id
}