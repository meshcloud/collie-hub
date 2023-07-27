variable "subscription_id" {
  type        = string
  nullable    = false
  description = "id of the logging subscription"
}

variable "platform_management_group_id" {
  type        = string
  nullable    = false
  description = "id of the platform management group"
}

variable "admin_management_group_id" {
  type        = string
  nullable    = false
  description = "id of the admin management group"
}

variable "cloudfoundation_deploy_principal_id" {
  type        = string
  nullable    = false
  description = "something"
}
variable "log_retention_in_days" {
  type        = number
  nullable    = false
  description = "something"
  default     = 30
}