# Place your module's terraform resources here as usual.
# Note that you should typically not put a terraform{} block into cloud foundation kit modules,
# these will be provided by the platform implementations using this kit module.

module "meshplatform" {
  source  = "registry.terraform.io/meshcloud/meshplatform/azure"
  version = "0.6.0"

  metering_enabled                      = var.metering_enabled
  metering_service_principal_name       = var.metering_service_principal_name
  metering_assignment_scopes            = var.metering_assignment_scopes
  sso_enabled                           = var.sso_enabled
  replicator_enabled                    = var.replicator_enabled
  replicator_rg_enabled                 = var.replicator_rg_enabled
  replicator_service_principal_name     = var.replicator_service_principal_name
  replicator_custom_role_scope          = var.replicator_custom_role_scope
  replicator_assignment_scopes          = var.replicator_assignment_scopes
  additional_permissions                = var.additional_permissions
  additional_required_resource_accesses = var.additional_required_resource_accesses
  create_passwords                      = var.create_passwords
  workload_identity_federation          = var.workload_identity_federation
  can_cancel_subscriptions_in_scopes    = var.can_cancel_subscriptions_in_scopes
}
