# variable "parentManagementGroup" {
#   default = "lv-foundation"
# }

variable "landingzones" {
  default = "lv-landingzones"
}

variable "lz-serverless" {
  default = "lv-corp"
}

variable "location" {
  type        = string
  description = "The Azure location where this policy assignment should exist, required when an Identity is assigned."
  default     = "germanywestcentral"
}
