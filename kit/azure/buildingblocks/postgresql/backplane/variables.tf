variable "name" {
  type     = string
  nullable = false
  default  = "postgresql"
}

variable "scope" {
  type        = string
  nullable    = false
  description = "Scope where the building block should be deployable, typically the parent of all Landing Zones."
}

variable "principal_ids" {
  type        = set(string)
  nullable    = false
  description = "set of principal ids that will be granted permissions to deploy the building block"
}
