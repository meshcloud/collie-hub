variable "scope" {
  type        = string
  nullable    = false
  description = "id of the management group that you want to collect activity logs from"
}

variable "logging_subscription_name" {
  type        = string
  default     = "logging"
  description = "Name of your logging subscription"
}

variable "log_retention_in_days" {
  type        = number
  nullable    = false
  description = "amount of time of log retention"
  default     = 30
}

variable "cloudfoundation" {
  type        = string
  nullable    = false
  description = "this is the name of your cloud foundation"
}

variable "parent_management_group_id" {
  type        = string
  nullable    = false
  description = "id of the parent management group that the logging subscription will be placed under"
}

variable "cloudfoundation_deploy_principal_id" {
  type        = string
  nullable    = false
  description = "Principal ID authorized for deploying Cloud Foundation resources"
}

variable "location" {
  type        = string
  nullable    = false
  description = "location of the resources created for logging"
}

variable "security_admin_group" {
  type        = string
  default     = "cloudfoundation-security-admins"
  description = "the name of the cloud foundation security admin group"
}

variable "security_auditor_group" {
  type        = string
  default     = "cloudfoundation-security-auditors"
  description = "the name of the cloud foundation security auditor group"
}
