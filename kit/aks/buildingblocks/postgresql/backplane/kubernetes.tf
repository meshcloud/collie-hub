resource "kubernetes_service_account" "bb_postgresql" {
  metadata {
    name      = "bb-postgresql"
    namespace = "meshcloud"
  }
}

resource "kubernetes_secret" "bb_postgresql" {
  metadata {
    name      = "bb-postgresql"
    namespace = "meshcloud"
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.bb_postgresql.metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}

resource "kubernetes_cluster_role" "bb_postgresql" {
  metadata {
    name = "bb-postgresql"
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "bb_postgresql" {
  metadata {
    name = "bb-postgresql"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "bb-postgresql"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "bb-postgresql"
    namespace = "meshcloud"
  }
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  resource_group_name = "aks-rg"
}
