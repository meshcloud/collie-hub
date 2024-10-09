terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "2.53.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}
