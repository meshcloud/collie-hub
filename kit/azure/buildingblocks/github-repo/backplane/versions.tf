terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }

    github = {
      source  = "integrations/github"
      version = "5.42.0"
    }
  }
}
