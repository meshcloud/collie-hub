variable "aad_tenant_id" {
  type        = string
  description = "Id of the AAD Tenant. This is also the simultaneously the id of the root management group."
}

variable "billing_users" {
  description = "The list of users identified by their UPN that shall be granted billing access"
  type = list(object({
    email = string,
    upn   = string,
  }))
  default = []
}
