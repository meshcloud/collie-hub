terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.34.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.81.0"
    }
  }
}
