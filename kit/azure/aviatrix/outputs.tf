output "client_id" {
  value = azuread_service_principal.aviatrix_deploy.client_id
}

output "client_secret" {
  value     = azuread_application_password.aviatrix_deploy.value
  sensitive = true
}

output "client_principal_id" {
  value = azuread_service_principal.aviatrix_deploy.id
}

output "aviatrix_service_principal" {
  value = azuread_application.aviatrix_deploy.display_name
}
