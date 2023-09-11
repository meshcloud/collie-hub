output "client_id" {
  value = azuread_service_principal.cloudfoundation_deploy.application_id
}

output "client_secret" {
  value     = azuread_service_principal_password.cloudfoundation_deploy.value
  sensitive = true
}

output "client_principal_id" {
  value = azuread_service_principal.cloudfoundation_deploy.id
}

output "platform_engineers_azuread_group_id" {
  value = azuread_group.platform_engineers.id
}

