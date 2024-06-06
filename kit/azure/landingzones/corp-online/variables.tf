variable "parent_management_group_id" {
  description = "The tenant management group of your cloud foundation"
  default     = "lv-foundation"
}

variable "cloudfoundation" {
  type        = string
  nullable    = false
  description = "the name of your cloudfoundation"
}

variable "landingzones" {
  description = "The parent_management_group where your landingzones are"
  default     = "lv-landingzones"
}

variable "corp" {
  default = "corp"
}

variable "online" {
  default = "online"
}

variable "location" {
  type        = string
  description = "The Azure location where this policy assignment should exist, required when an Identity is assigned."
  default     = "germanywestcentral"
}

variable "vnet_address_space_id" {
  type        = string
  description = "The address space of the hub vnet for the policy assignment"
}
