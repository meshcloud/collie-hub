variable "parent_management_group_id" {
  description = "id of the parent management group for the landing zone's management group"
}

variable "name" {
  description = "name of the landing zone's management group"
  default     = "cloudnative"
}

variable "location" {
  type        = string
  description = "The Azure location where this policy assignment should exist, required when an Identity is assigned."
  default     = "germanywestcentral"
}
