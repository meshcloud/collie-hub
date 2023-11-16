module "meshplatform" {
  source  = "meshcloud/meshplatform/azure"
  version = "0.3.2"

  additional_permissions                = var.additional_permissions
  additional_required_resource_accesses = var.additional_required_resource_accesses
  idplookup_enabled                     = var.idplookup_enabled
  metering_enabled                      = var.kraken_enabled
  mgmt_group_name                       = var.mgmt_group_name
  replicator_enabled                    = var.replicator_enabled
  service_principal_name_suffix         = var.service_principal_name_suffix
  subscriptions                         = var.subscriptions
}
