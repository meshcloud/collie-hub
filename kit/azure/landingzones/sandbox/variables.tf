variable "parent_management_group_id" {
  description = "The tenant management group of your cloud foundation"
  default     = "lv-foundation"
}

variable "landingzones" {
  description = "The parent_management_group where your landingzones are"
  default     = "lv-landingzones"
}

variable "serverless" {
  default = "serverless"
}

variable "location" {
  type        = string
  description = "The Azure location where this policy assignment should exist, required when an Identity is assigned."
  default     = "germanywestcentral"
}
