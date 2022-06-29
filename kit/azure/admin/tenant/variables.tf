variable "aad_tenant_id" {
  type        = string
  description = "Id of the AAD Tenant. This is also the simultaneously the id of the root management group."
}

variable "platform_management_group_name" {
  type        = string
  nullable    = false
  description = <<EOF
    Create a management group of the specified name and treat it as the root of all resources managed as part of this kit.
    This managment group will sit directly below the root management group (AAD Tenant).
    This is good for separationg, in particular if you don't have exclusive control over the AAD Tenant because
    it is supporting non-cloudfoundation workloads as well.
  EOF
}

variable "allowed_locations" {
  type        = list(string)
  description = "Allowed Azure regions."
}

variable "billing_users" {
  description = "The list of users identified by their UPN that shall be granted billing access"
  type = list(object({
    email = string,
    upn   = string,
  }))
  default = []
}
