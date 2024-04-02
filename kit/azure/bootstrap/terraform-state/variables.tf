variable "location" {
  type        = string
  nullable    = false
  description = "Azure location for deploying the storage account"
}

variable "terraform_state_config_file_path" {
  type        = string
  nullable    = false
  description = "tfstate-config file for running the bootstrap"
}

variable "cloudfoundation" {
  type        = string
  nullable    = false
  description = "cloudfoundation name to infer resource group for the statefiles"
}

variable "resource_group_name" {
  type        = string
  nullable    = true
  description = "explicitly override default resource_group_name (useful for migrating from legacy versions of this kit module)"
}
