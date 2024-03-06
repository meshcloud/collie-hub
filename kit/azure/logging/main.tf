# configure our logging subscription
data "azurerm_subscription" "current" {
}

#  add a name to the existing subscription
resource "azurerm_subscription" "logging" {
  subscription_id   = data.azurerm_subscription.current.subscription_id
  subscription_name = var.logging_subscription_name
}

resource "azurerm_management_group_subscription_association" "logging" {
  subscription_id     = data.azurerm_subscription.current.id
  management_group_id = var.parent_management_group_id
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

## Creates a RG for LAW
resource "azurerm_resource_group" "law_rg" {
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
  logging_remediation_roles = toset([
    "Monitoring Contributor",
    "Log Analytics Contributor"
  ])
}

resource "azurerm_role_assignment" "logging" {
  for_each             = local.logging_remediation_roles
  role_definition_name = each.key
  principal_id         = module.policy_law.policy_assignments["Deploy-AzActivity-Log"].identity[0].principal_id
  scope                = var.scope
}


# enables logging on management_group level
resource "azapi_resource" "diag-setting-management-group" {
  type                    = "Microsoft.Insights/diagnosticSettings@2021-05-01-preview"
  name                    = "toLogAnalyticsWorkspace"
  parent_id               = var.scope  
  ignore_missing_property = true
  body = jsonencode({
    properties = {
      workspaceId                 = azurerm_log_analytics_workspace.law.id
      logs = [
        {
          category = "Administrative"
          enabled  = true
          retentionPolicy = {
            days    = 0
            enabled = false
          }
        },
        {
          category = "Policy"
          enabled  = false
          retentionPolicy = {
            days    = 0
            enabled = false
          }
        }
      ]
    }
  })
}

# creates group and permissions for security admins
resource "azuread_group" "security_admins" {
  display_name     = var.security_admin_group
  description      = "Privileged Cloud Foundation group. Members have full access to Azure Security Center, Policies and Audit Logs."
  security_enabled = true
}

resource "azurerm_role_assignment" "security_admins_law" {
  role_definition_name = "Log Analytics Contributor"
  principal_id         = azuread_group.security_admins.object_id
  scope                = var.scope
}

resource "azurerm_role_assignment" "security_admins" {
  role_definition_name = "Security Admin"
  principal_id         = azuread_group.security_admins.object_id
  scope                = var.scope
}

# creates group and permissions for security auditors
resource "azuread_group" "security_auditors" {
  display_name     = var.security_auditor_group
  description      = "Privileged Cloud Foundation group. Members have read-only access to Azure Security Center, Policies and Audit Logs."
  security_enabled = true
}

resource "azurerm_role_assignment" "security_auditors_law" {
  role_definition_name = "Log Analytics Reader"
  principal_id         = azuread_group.security_auditors.object_id
  scope                = var.scope
}

resource "azurerm_role_assignment" "security_auditors" {
  role_definition_name = "Security Reader"
  principal_id         = azuread_group.security_auditors.object_id
  scope                = var.scope
}
