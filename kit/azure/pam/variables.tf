variable "billing_admin" {
  description = "this variable fetchs the output values of the billing kit"
  type = object({
    group = object({ object_id = string, display_name = string })
  })
}

variable "billing_admin_members" {
  description = "Admins for Cost Management"
  type = list(object({
    email = string,
    upn   = string,
  }))
}

variable "billing_reader" {
  description = "this variable fetchs the output values of the billing kit"
  type = object({
    group = object({ object_id = string, display_name = string })
  })
}

variable "billing_reader_members" {
  description = "Auditors for Cost Management"
  type = list(object({
    email = string,
    upn   = string,
  }))
}

variable "security_auditor" {
  description = "this variable fetchs the output values of the logging kit"
  type = object({
    group = object({ object_id = string, display_name = string })
  })
}

variable "security_auditor_members" {
  description = "Security Auditors for the Log Analytics Workspace"
  type = list(object({
    email = string,
    upn   = string,
  }))
}
