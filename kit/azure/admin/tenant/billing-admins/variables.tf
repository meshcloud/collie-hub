variable "aad_tenant_id" {
  type = string
}

variable "billing_users" {
  description = "The list of users identified by their UPN that shall be granted billing access"
  type = list(object({
    email = string,
    upn   = string,
  }))
}
