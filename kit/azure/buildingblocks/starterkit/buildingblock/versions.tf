terraform {
  required_version = ">= 1.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.42.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "3.0.2"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}

