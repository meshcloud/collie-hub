variable "budget_name" {
  type        = string
  description = "Name of the budget alert rule"
  default     = "budget_alert"
}

variable "subscription_id" {
  type        = string
  description = "The ID of the subscription at which you want to assign the budget"
}

variable "contact_emails" {
  type        = string
  description = "Comma-separated list of emails of the users who should receive the Budget alert. e.g. 'foo@example.com, bar@example.com'"
}

variable "monthly_budget_amount" {
  type        = number
  description = "Set the monthly budget for this subscription in the billing currency."
}

variable "actual_threshold_percent" {
  type        = number
  description = "The precise percentage of the monthly budget at which you wish to activate the alert upon reaching. E.g. '15' for 15% or '120' for 120%"
  default     = 80
}

variable "forcasted_threshold_percent" {
  type        = number
  description = "The forcasted percentage of the monthly budget at which you wish to activate the alert upon reaching. E.g. '15' for 15% or '120' for 120%"
  default     = 100
}
