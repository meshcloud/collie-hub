variable "subscription_name" {
  description = "Display name for the subscription."
  nullable    = false
}

variable "parent_management_group" {
  description = "Display name of the parent management group. This will be looked up dynamically from Azure."
  nullable    = false
}
