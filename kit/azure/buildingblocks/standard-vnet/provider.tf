//---------------------------------------------------------------------------
// Terraform Settings
//---------------------------------------------------------------------------
terraform {
  # backend "gcs" {
  #   bucket = "meshcloud-tf-states"
  #   prefix = "meshcloud-demo/building-blocks/service-principal"
  # }
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3.0.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">2.0.0"
    }
  }
}

provider "azuread" {

}

provider "azurerm" {
  features {

  }
}
