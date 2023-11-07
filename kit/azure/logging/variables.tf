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

variable "cloudfoundation" {
  type        = string
  nullable    = false
  description = "this is the name of your cloud-foundation"
}

variable "location" {
  type        = string
  nullable    = false
  description = "location of the resources"
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
