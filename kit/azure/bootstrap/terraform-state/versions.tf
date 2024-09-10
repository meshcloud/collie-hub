terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

