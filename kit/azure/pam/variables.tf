variable "billing_admin_members" {
  description = "Set up a group of platform engineers. If enabled, this group will receive access to terraform_state_storage"
  type = list(object({
    email = string,
    upn   = string,
  }))
}

variable "billing_reader_members" {
  description = "Set up a group of platform engineers. If enabled, this group will receive access to terraform_state_storage"
  type = list(object({
    email = string,
    upn   = string,
  }))
}

variable "security_auditor_members" {
  description = "Set up a group of platform engineers. If enabled, this group will receive access to terraform_state_storage"
  type = list(object({
    email = string,
    upn   = string,
  }))
}
