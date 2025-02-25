# Service account for GHA to use
resource "kubernetes_service_account" "github_actions" {
  metadata {
    name      = "github-actions"
    namespace = var.namespace
  }
}

resource "kubernetes_secret" "github_actions" {
  metadata {
    name      = "github-actions"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.github_actions.metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}

resource "kubernetes_role" "github_actions" {
  metadata {
    name      = "github-actions"
    namespace = var.namespace
  }

  # manage a secret for pulling images from GitHub container registry
  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    resource_names = ["github-image-pull"]
    verbs          = ["*"]
  }

  # manage deployments
  rule {
    api_groups = ["apps"]
    resources  = ["deployments"]
    verbs      = ["*"]
  }
}

resource "kubernetes_role_binding" "github_actions" {
  metadata {
    name      = "github-actions"
    namespace = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.github_actions.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.github_actions.metadata[0].name
    namespace = var.namespace
  }
}

resource "kubernetes_secret" "image_pull" {
  metadata {
    name      = "acr-image-pull"
    namespace = var.namespace
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        (local.acr.host) = {
          "username" = local.acr.username
          "password" = local.acr.password
          "auth"     = base64encode("${local.acr.username}:${local.acr.password}")
        }
      }
    })
  }
}
