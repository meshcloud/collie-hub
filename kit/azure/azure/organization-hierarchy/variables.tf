variable "management_subscription_name" {
  type        = string
  default     = "management"
  description = "Name of your management subscription"
}

variable "parent_management_group_name" {
  default = "foundation"
}

variable "landingzones" {
  default = "landingzones"
}

variable "platform" {
  default = "platform"
}

variable "connectivity" {
  default = "connectivity"
}

variable "identity" {
  default = "identity"
}

variable "management" {
  default = "management"
}

variable "locations" {
  type        = list(string)
  description = "This is for the Azure Allowed locations. Additionally, we use the first added locations where this policy assignment should exist, which is required when an identity is assigned."
  default     = ["germanywestcentral"]
}
