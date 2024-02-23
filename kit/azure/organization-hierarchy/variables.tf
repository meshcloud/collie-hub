variable "management_subscription_name" {
  type        = string
  default     = "management"
  description = "Name of your management subscription"
}

variable "parentManagementGroup" {
  default = "lv-foundation"
}

variable "landingzones" {
  default = "lv-landingzones"
}

variable "platform" {
  default = "lv-platform"
}

variable "connectivity" {
  default = "lv-connectivity"
}

variable "identity" {
  default = "lv-identity"
}

variable "management" {
  default = "lv-management"
}

variable "locations" {
  type        = list(string)
  description = "This is for the Azure Allowed locations. Additionally, we use the first added locations where this policy assignment should exist, which is required when an identity is assigned."
  default     = ["germanywestcentral"]
}
