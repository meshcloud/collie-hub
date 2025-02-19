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
