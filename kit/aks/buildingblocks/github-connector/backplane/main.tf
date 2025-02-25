# BB creates
# - service account with permissions to
#   - manage a "github-image-pull-secret"
#   - manage pods and deployments
#
# BB puts kubeconfig for this SA into GH
#
# GHA workflow uses this SA to
# - update image pull secret
# - deployment
#
data "azurerm_subscription" "current" {
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  resource_group_name = "aks-rg"
}

resource "azurerm_resource_group" "bb_github_connector" {
  name     = "bb-github-connector"
  location = "Germany West Central"
}

# SPN for Terraform state

resource "azuread_application" "bb_github_connector" {
  display_name = "bb-github-connector"
}

resource "azuread_service_principal" "bb_github_connector" {
  client_id = azuread_application.bb_github_connector.client_id
}

resource "azuread_service_principal_password" "bb_github_connector" {
  service_principal_id = azuread_service_principal.bb_github_connector.id
}

resource "azurerm_role_assignment" "bb_github_connector" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor" # TODO: restrict permissions
  principal_id         = azuread_service_principal.bb_github_connector.object_id
}

resource "azurerm_role_assignment" "terraform_state" {
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_service_principal.bb_github_connector.object_id
  scope                = var.tfstates_resource_manager_id
}

# Container registry
# We're using a shared container registry for all consumers of this building block.
# This could easily be changed to deploy a dedicated container registry per building block
# or by making the container registry configurable.

resource "azurerm_container_registry" "acr" {
  name                = "githubconnector"
  resource_group_name = azurerm_resource_group.bb_github_connector.name
  location            = azurerm_resource_group.bb_github_connector.location
  sku                 = "Basic"
}

resource "azuread_application" "bb_github_connector_acr" {
  display_name = "bb-github-connector-acr"
}

resource "azuread_service_principal" "bb_github_connector_acr" {
  client_id = azuread_application.bb_github_connector_acr.client_id
}

resource "azuread_service_principal_password" "bb_github_connector_acr" {
  service_principal_id = azuread_service_principal.bb_github_connector_acr.id
}

resource "azurerm_role_assignment" "bb_github_connector_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.bb_github_connector_acr.object_id
}
