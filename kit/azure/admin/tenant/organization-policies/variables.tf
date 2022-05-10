variable "aad_tenant_id" {
  type        = string
  description = "Id of the AAD Tenant. This is also the simultaneously the id of the root management group."
}

variable "allowed_locations" {
  type        = list(string)
  description = "Allowed Azure regions."
}