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

output "resources_cloudfoundation" {
  value = var.resources_cloudfoundation
}
	
