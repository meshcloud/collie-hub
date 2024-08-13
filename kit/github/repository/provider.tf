terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.34.0"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}
