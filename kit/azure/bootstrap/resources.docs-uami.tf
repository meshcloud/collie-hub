resource "azurerm_user_assigned_identity" "docs" {
  count = var.documentation_uami != null ? 1 : 0

  location            = var.terraform_state_storage.location
  name                = var.documentation_uami.name
  resource_group_name = module.terraform_state.resource_group_name
}

# see https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure#adding-the-federated-credentials-to-azure
resource "azurerm_federated_identity_credential" "docs" {
  count = var.documentation_uami != null ? 1 : 0

  parent_id           = azurerm_user_assigned_identity.docs[0].id
  resource_group_name = module.terraform_state.resource_group_name

  name     = "github-actions"
  audience = ["api://AzureADTokenExchange"]
  issuer   = "https://token.actions.githubusercontent.com"

  # note: it seems wildcards are not supported yet, see https://github.com/Azure/azure-workload-identity/issues/373
  subject = var.documentation_uami.oidc_subject
}

resource "azurerm_role_assignment" "docs_tfstate" {
  count = var.documentation_uami != null ? 1 : 0

  # allow reading terraform state
  # important caveat: can read all secrets that are stored in tfstate and thus could use it to escalate privileges
  role_definition_name = "Storage Blob Data Reader"

  principal_id = azurerm_user_assigned_identity.docs[0].principal_id
  scope        = module.terraform_state.container_id
}