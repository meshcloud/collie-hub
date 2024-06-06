variable "parent_management_group" {
  type        = string
  nullable    = false
  description = "id of the tenant management group"
}

variable "service_principal_name" {
  type        = string
  nullable    = false
  default     = "avaitrix_deploy_spn"
  description = "id of the tenant management group"
}

variable "allowed_user_group_id" {
  type        = list(string)
  nullable    = false
  description = "id of the authorized id which can do changes"
}

variable "location" {
  type        = string
  description = "The Azure location used for creating policy assignments establishing this landing zone's guardrails."
}
