variable "allowed_locations" {
  type        = list(string)
  description = "Allowed Azure regions."
}
variable "parent_mg_id" {
  type = string
  description = "parent folder ID"
}
