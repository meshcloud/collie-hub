terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "0.6.0-beta2"
    }
  }
}

provider "btp" {
  globalaccount = var.globalaccount
  # username: use BTP_USERNAME environment variable
  # password: use BTP_PASSWORD environment variable
}
