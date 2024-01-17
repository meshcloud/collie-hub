module "meshplatform" {
  source  = "meshcloud/meshplatform/azure"
  version = "0.4.0"

  metering_enabled                      = var.metering_enabled
  metering_service_principal_name       = var.metering_service_principal_name
  metering_assignment_scopes            = var.metering_assignment_scopes
  sso_enabled                           = var.sso_enabled
  replicator_enabled                    = var.replicator_enabled
  replicator_service_principal_name     = var.replicator_service_principal_name
  replicator_custom_role_scope          = var.replicator_custom_role_scope
  replicator_assignment_scopes          = var.replicator_assignment_scopes
  additional_permissions                = var.additional_permissions
  additional_required_resource_accesses = var.additional_required_resource_accesses

}
