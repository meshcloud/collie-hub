terraform {

  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~> 3.106.1"
      configuration_aliases = [azurerm.spoke, azurerm.hub]
    }

    time = {
      source  = "hashicorp/time"
      version = "0.11.1"
    }
  }
}
