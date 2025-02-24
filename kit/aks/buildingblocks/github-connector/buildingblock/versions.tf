terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.5.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }

  }
}
