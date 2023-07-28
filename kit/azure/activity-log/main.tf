resource "azurecaf_name" "cafrandom_rg" {
  name = var.resources_cloudfoundation
  resource_type    = "azurerm_resource_group"
  prefixes  = ["law"]
  random_length = 3
}

# configure our logging subscription

data "azurerm_subscription" "current" {
}

# Set up permissions for deploy user
resource "azurerm_role_definition" "cloudfoundation_tfdeploy" {
  name  = "${var.resources_cloudfoundation}_log_workspace"
  scope = data.azurerm_subscription.current.id
  permissions {
    actions = ["Microsoft.Resources/subscriptions/resourcegroups/write"]
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
    azurerm_role_definition.cloudfoundation_tfdeploy
  ]
  name     = azurecaf_name.cafrandom_rg.result
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

# Deploy "Configure Azure Activity logs to stream to specified Log Analytics workspace" Policy definition

locals {
  builtin_azurerm_policy_definition_names = {
    activity_log = "2465583e-4e78-4c15-b6be-a36cbc7c8b0f"
  }
}

data "azurerm_policy_definition" "activity_log" {
  name = local.builtin_azurerm_policy_definition_names.activity_log
}

resource "azurerm_management_group_policy_assignment" "activity_log" {
  name                 = "activity-log-policy"
  management_group_id  = var.platform_management_group_id
  policy_definition_id = data.azurerm_policy_definition.activity_log.id
  description          = "Configure Azure Activity logs to stream to specified Log Analytics workspace"
  display_name         = "Stream Activity Logs to Log Analytics Workspace"
  location             = azurerm_resource_group.law_rg.location
  
  parameters = jsonencode({
    logAnalytics = {
      value = azurerm_log_analytics_workspace.law.id
    }
  })

  identity {
    type = "SystemAssigned"
  }
}

# Configre Remediation

locals {
  activity_log_remediation_roles = toset([
    "Monitoring Contributor", 
    "Log Analytics Contributor"
  ])
}

resource "azurerm_role_assignment" "activity_log" {
  for_each = local.activity_log_remediation_roles
  role_definition_name = each.key

  principal_id = azurerm_management_group_policy_assignment.activity_log.identity[0].principal_id
  scope = var.platform_management_group_id
}
