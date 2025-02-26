terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "1.5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}
