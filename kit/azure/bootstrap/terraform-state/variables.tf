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
  description = "the name of your cloudfoundation"
}
