variable "lift_and_shift_subscription_name" {
  type        = string
  description = "The name the subscription should be renamed to."
}

variable "parent_management_group_id" {
  type        = string
  description = "The ID of the management group to associate the subscription with."
}
