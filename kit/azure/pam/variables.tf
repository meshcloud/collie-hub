variable "billing_admin_group" {
  description = "object_id of the billing admin group"
  type        = string
}

variable "billing_admin_members" {
  description = "Set up a group of billing readers. This group will receive admin access to Cost Management"
  type = list(object({
    email = string,
    upn   = string,
  }))
}

variable "billing_reader_group" {
  description = "object_id of the billing reader group"
  type        = string
}

variable "billing_reader_members" {
  description = "Set up a group of billing readers. This group will receive access to Cost Management"
  type = list(object({
    email = string,
    upn   = string,
  }))
}

variable "security_auditor_group" {
  description = "object_id of the security auditor group"
  type        = string
}

variable "security_auditor_members" {
  description = "Set up a group of Security Auditors. This group will receive access to the Log Analytics Workspace (law)"
  type = list(object({
    email = string,
    upn   = string,
  }))
}
