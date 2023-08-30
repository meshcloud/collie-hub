variable "subscription_id" {
  type        = string
  nullable    = false
  description = "id of the logging subscription"
}

variable "scope" {
  type        = string
  nullable    = false
  description = "id of the management group that you want to log"
}

variable "cloudfoundation_deploy_principal_id" {
  type        = string
  nullable    = false
  description = "service principal id"
}
variable "log_retention_in_days" {
  type        = number
  nullable    = false
  description = "amount of time of log retention"
  default     = 30
}

variable "resources_cloudfoundation" {
  type        = string
  nullable    = false
  description = "tfstate resource group for the statefiles"
}

variable "location" {
  type        = string
  nullable    = false
  description = "location of the resources"
}
