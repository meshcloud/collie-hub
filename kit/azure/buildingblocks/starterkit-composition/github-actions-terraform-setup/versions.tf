terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.4.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "3.0.2"
    }

    github = {
      source  = "integrations/github"
      version = "6.3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.11.1"
    }
  }
}

