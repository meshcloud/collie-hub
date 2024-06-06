data "azurerm_key_vault" "cloudfoundation_keyvault" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg
}

data "azurerm_key_vault_secret" "github_token" {
  name         = var.github_token_secret_name
  key_vault_id = data.azurerm_key_vault.cloudfoundation_keyvault.id
}

provider "github" {
  owner = var.github_org
  app_auth {
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = data.azurerm_key_vault_secret.github_token.value
  }
}

resource "github_repository" "repository" {
  count                = var.create_new ? 1 : 0
  name                 = var.repo_name
  description          = var.description
  visibility           = var.visibility
  auto_init            = false
  vulnerability_alerts = true

  dynamic "template" {
    for_each = var.use_template ? [1] : []
    content {
      owner                = var.template_owner
      repository           = var.template_repo
      include_all_branches = true
    }
  }
}
