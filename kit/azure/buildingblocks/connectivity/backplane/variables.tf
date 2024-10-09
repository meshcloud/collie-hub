variable "name" {
  type        = string
  nullable    = false
  description = "name of the building block, used for naming resources"
  validation {
    condition     = can(regex("^[-a-z0-9]+$", var.name))
    error_message = "Only alphanumeric lowercase characters and dashes are allowed"
  }
}

variable "principal_ids" {
  type        = set(string)
  nullable    = false
  description = "set of principal ids that will be granted permissions to deploy the building block"
}
