variable "parent_management_group_id" {
  description = "The tenant management group of your cloud foundation"
  default     = "foundation"
}

variable "lz-container-platform" {
  default = "container-platform"
}

variable "location" {
  type        = string
  description = "The Azure location where this policy assignment should exist, required when an Identity is assigned."
  default     = "germanywestcentral"
}
