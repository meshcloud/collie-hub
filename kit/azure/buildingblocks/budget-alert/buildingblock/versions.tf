terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.108.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.11.1"
    }
  }
}

