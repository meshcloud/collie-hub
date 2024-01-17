output "meshplatform" {
  value     = module.meshplatform
  sensitive = true
}
output "replicator_credentials" {
  description = "Replicator Service Principal."
  value       = module.meshplatform.replicator_service_principal
}
output "replicator_client_secret" {
  description = "Password for Replicator Service Principal."
  value       = module.meshplatform.replicator_service_principal_password
  sensitive   = true
}
output "metering_credentials" {
  description = "Metering Service Principal."
  value       = module.meshplatform.metering_service_principal
}
output "metering_client_secret" {
  description = "Password for Metering Service Principal."
  value       = module.meshplatform.metering_service_principal_password
  sensitive   = true
}
output "azure_ad_tenant_id" {
  description = "The Azure AD tenant id."
  value       = module.meshplatform.azure_ad_tenant_id
}
