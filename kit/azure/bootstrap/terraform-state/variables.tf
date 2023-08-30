variable "location" {
  type        = string
  nullable    = false
  description = "Azure location for deploying the storage account"
}

variable "file_path" {
  type        = string
  nullable    = false
  description = "tfstate-config file for running the bootstrap"
}

variable "resources_cloudfoundation" {
  type        = string
  nullable    = false
  description = "tfstate resource group for the statefiles"
}
