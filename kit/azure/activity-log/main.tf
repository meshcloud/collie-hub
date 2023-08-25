# configure our logging subscription
data "azurerm_subscription" "current" {
}

module "policy_law" {
  source              = "github.com/meshcloud/collie-hub//kit/azure/util/azure-policies?ref=ef06c8d43611dd3bf6eebdd7f472b95472f86b0b"
  policy_path         = "${path.module}/lib/"
  management_group_id = var.scope
  location            = var.location

  template_file_variables = {
    default_location          = var.location
    current_scope_resource_id = var.scope
    workspace_id              = azurerm_log_analytics_workspace.law.id
  }
}

# Set up permissions for deploy user
resource "azurerm_role_definition" "cloudfoundation_tfdeploy" {
  name  = "${var.cloudfoundation}_log_workspace"
  scope = data.azurerm_subscription.current.id
  permissions {
    actions = ["Microsoft.Resources/subscriptions/resourceGroups/write",
      "Microsoft.Resources/subscriptions/resourceGroups/delete",
      # Permissions for log workspaces
      "Microsoft.OperationalInsights/workspaces/*",
      "Microsoft.OperationalInsights/workspaces/linkedServices/*",
      # Permissions for log workspace solution
      "Microsoft.OperationsManagement/solutions/*",
      # Permissions for automation accounts
    "Microsoft.Automation/automationAccounts/*"]
  }
}

resource "azurerm_role_assignment" "cloudfoundation_tfdeploy" {
  principal_id       = var.cloudfoundation_deploy_principal_id
  scope              = data.azurerm_subscription.current.id
  role_definition_id = azurerm_role_definition.cloudfoundation_tfdeploy.role_definition_resource_id
}

## Creates a RG for LAW
resource "azurerm_resource_group" "law_rg" {
  depends_on = [
    azurerm_role_assignment.cloudfoundation_tfdeploy
  ]
  name     = "law-rg-${var.cloudfoundation}"
  location = var.location
}

# Creates Log Anaylytics Workspace
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "log-analytics-workspace"
  location            = azurerm_resource_group.law_rg.location
  resource_group_name = azurerm_resource_group.law_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_in_days
}

locals {
  activity_log_remediation_roles = toset([
    "Monitoring Contributor",
    "Log Analytics Contributor"
  ])
}

resource "azurerm_role_assignment" "activity_log" {
  for_each             = local.activity_log_remediation_roles
  role_definition_name = each.key
  principal_id         = module.policy_law.policy_assignments["Deploy-AzActivity-Log"].identity[0].principal_id
  scope                = var.scope
}
