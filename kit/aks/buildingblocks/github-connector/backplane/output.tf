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
      key                   = "bb-github-connector.tfstate"

      client_id             = "${azuread_service_principal.bb_github_connector.client_id}"
      client_secret         = "${azuread_service_principal_password.bb_github_connector.value}"
    }
  }

  provider "kubernetes" {
    host = "${data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].host}"
    cluster_ca_certificate = base64decode("${data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate}")
    client_certificate = base64decode("${data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate}")
    client_key = base64decode("${data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key}")
  }

  provider "github" {
    owner = "likvid-bank"

    app_auth {
      id = "654209"
      installation_id = "44437049"
      pem_file = file("./likvid-bank-devops-toolchain-team.private-key.pem")
    }
  }

  locals {
    aks_kubeconfig_stub = {
      apiVersion = "v1"
      kind = "Config"
      current-context = "aks"

      clusters = [
        {
          name = "aks"
          cluster = {
            server = "${data.azurerm_kubernetes_cluster.aks.kube_config[0].host}"
            certificate-authority-data = "${data.azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate}"
          }
        }
      ]
    }

    acr = {
      host =  "${azurerm_container_registry.acr.login_server}"
      username = "${azuread_service_principal.bb_github_connector_acr.client_id}"
      password = "${azuread_service_principal_password.bb_github_connector_acr.value}"
    }
  }
  EOF
}

