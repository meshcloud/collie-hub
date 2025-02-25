output "config_tf" {
  description = "Generates a config.tf that can be dropped into meshStack's BuildingBlockDefinition as an encrypted file input to configure this building block."
  sensitive   = true
  value       = <<-EOF
  terraform {
    backend "azurerm" {
      use_azuread_auth      = true
      tenant_id             = "${data.azurerm_subscription.current.tenant_id}"
      subscription_id       = "${data.azurerm_subscription.current.subscription_id}"
      resource_group_name   = "${var.tfstates_resource_group_name}"
      storage_account_name  = "${var.tfstates_storage_account_name}"
      container_name        = "${var.tfstates_storage_container_name}"
      key                   = "bb-postgresql.tfstate"

      client_id             = "${azuread_service_principal.bb_postgresql.client_id}"
      client_secret         = "${azuread_service_principal_password.bb_postgresql.value}"
    }
  }

  provider "azurerm" {
    features {
      resource_group {
        prevent_deletion_if_contains_resources = false # This allows the deletion of the building block without having to separately delete the app resources
      }
    }

    resource_provider_registrations = "core"

    storage_use_azuread        = true

    tenant_id       = "${data.azurerm_subscription.current.tenant_id}"
    subscription_id = "${data.azurerm_subscription.current.subscription_id}"
    client_id       = "${azuread_service_principal.bb_postgresql.client_id}"
    client_secret   = "${azuread_service_principal_password.bb_postgresql.value}"
  }

  provider "kubernetes" {
    host                   = "${data.azurerm_kubernetes_cluster.aks.kube_config[0].host}"
    token                  = "${kubernetes_secret.bb_postgresql.data["token"]}"
    cluster_ca_certificate = base64decode("${data.azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate}")
  }

  locals {
    resource_group_name = "${azurerm_resource_group.bb_postgresql.name}"
    location =  "${azurerm_resource_group.bb_postgresql.location}"
    subnet_id = "${azurerm_subnet.bb_postgresql.id}"
    private_dns_zone_id = "${azurerm_private_dns_zone.bb_postgresql.id}"
  }
  EOF
}
