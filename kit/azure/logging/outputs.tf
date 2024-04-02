output "security_admins_azuread_group_id" {
  value = azuread_group.security_admins.id
}

output "security_auditors_azuread_group_id" {
  value = azuread_group.security_auditors.id
}

output "logging_subscription" {
  value = data.azurerm_subscription.current.id
}

output "law_workspace_id" {
  value = azurerm_log_analytics_workspace.law.id
}

output "law_workspace_id_short" {
  value = azurerm_log_analytics_workspace.law.workspace_id
}

output "law_workspace_resource_id" {
  value = azurerm_resource_group.law_rg.id
}
