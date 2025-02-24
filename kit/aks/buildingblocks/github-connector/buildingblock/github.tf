locals {
  kubeconfig_user = {
    users = [
      {
        name = kubernetes_service_account.github_actions.metadata[0].name
        user = {
          "token" = kubernetes_secret.github_actions.data.token
        }
      }
    ]

    contexts = [
      {
        name = "aks"
        context = {
          cluster   = "aks"
          namespace = var.namespace
          user      = kubernetes_service_account.github_actions.metadata[0].name
        }
      }
    ]
  }
  kubeconfig = merge(local.aks_kubeconfig_stub, local.kubeconfig_user)
}

resource "github_actions_secret" "kubeconfig" {
  repository      = var.github_repo
  secret_name     = "KUBECONFIG"
  plaintext_value = yamlencode(local.kubeconfig)
}


resource "github_actions_secret" "container_registry" {
  for_each = {
    host     = local.acr.host
    username = local.acr.username
    password = local.acr.password
  }

  repository      = var.github_repo
  secret_name     = "aks_container_registry_${each.key}"
  plaintext_value = each.value
}

resource "github_repository_file" "dockerfile" {
  repository = var.github_repo

  file    = "Dockerfile"
  content = file("${path.module}/repo_content/Dockerfile")

  commit_message      = "Basic Dockerfile"
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [content]
  }
}

resource "github_repository_file" "workflow" {
  repository = var.github_repo

  file = ".github/workflows/build-deploy.yml"
  content = templatefile(
    "${path.module}/repo_content/workflow.yml",
    {
      namespace         = var.namespace,
      image_name        = var.github_repo,
      registry          = local.acr.host
      image_pull_secret = kubernetes_secret.image_pull.metadata[0].name
    }
  )

  commit_message      = "Worflow for building and deploying container images to AKS"
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [content]
  }
}
