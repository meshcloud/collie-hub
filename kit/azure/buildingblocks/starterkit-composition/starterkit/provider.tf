terraform {
  required_providers {
    meshstack = {
      source  = "meshcloud/meshstack"
      version = ">= 0.5.5"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.11.1"
    }
  }
}


provider "meshstack" {
  endpoint  = "https://federation.demo.meshcloud.io"
  apikey    = local.api_credentials[var.workspace_identifier].key
  apisecret = local.api_credentials[var.workspace_identifier].secret
}
