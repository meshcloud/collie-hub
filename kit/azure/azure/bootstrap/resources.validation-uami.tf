resource "azurerm_user_assigned_identity" "validation" {
  count = var.validation_uami != null ? 1 : 0

  location            = var.terraform_state_storage.location
  name                = var.validation_uami.name
  resource_group_name = module.terraform_state.resource_group_name
}

# see https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure#adding-the-federated-credentials-to-azure
resource "azurerm_federated_identity_credential" "validation" {
  count = var.validation_uami != null ? 1 : 0

  parent_id           = azurerm_user_assigned_identity.validation[0].id
  resource_group_name = module.terraform_state.resource_group_name

  name     = "github-actions"
  audience = ["api://AzureADTokenExchange"]
  issuer   = "https://token.actions.githubusercontent.com"

  # note: it seems wildcards are not supported yet, see https://github.com/Azure/azure-workload-identity/issues/373
  subject = var.validation_uami.oidc_subject
}

resource "azurerm_role_assignment" "validation_tfstate" {
  count = var.validation_uami != null ? 1 : 0

  # allow reading terraform state
  # important caveat: can read all secrets that are stored in tfstate and thus use it to escalate privileges
  role_definition_name = "Storage Blob Data Reader"

  principal_id = azurerm_user_assigned_identity.validation[0].principal_id
  scope        = module.terraform_state.container_id
}

resource "azurerm_role_definition" "validation_reader" {
  count = var.validation_uami != null ? 1 : 0

  name        = var.validation_uami.name
  scope       = data.azurerm_management_group.parent.id
  description = "grants permission to validate the deployment of the landing zone architecture (terraform apply)"

  permissions {
    actions = [
      "*/read", # read everything

      # required for terraform plan on azurerm_storage_account resource
      "Microsoft.Storage/storageAccounts/listKeys/action"
    ]
  }
}

resource "azurerm_role_assignment" "validation_reader" {
  count = var.validation_uami != null ? 1 : 0

  scope              = data.azurerm_management_group.parent.id
  role_definition_id = azurerm_role_definition.validation_reader[0].role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.validation[0].principal_id
}

resource "azuread_directory_role" "readers" {
  display_name = "Directory Readers"
}

resource "azuread_directory_role_assignment" "validation_reader" {
  count = var.validation_uami != null ? 1 : 0

  role_id             = azuread_directory_role.readers.template_id
  principal_object_id = azurerm_user_assigned_identity.validation[0].principal_id
}