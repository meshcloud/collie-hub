variable "scope" {
  type        = string
  nullable    = false
  description = "id of the tenant management group"
}

variable "budget_name" {
  type        = string
  default     = "cloudfoundation_budget"
  description = "the name of the budget alert"
}

variable "contact_mails" {
  default     = ["billingmeshi@meshithesheep.io"]
  type        = list(string)
  description = "The email address of the contact person for the cost alert"
}

variable "budget_time_period" {
  type = list(object({
    start = string,
    end   = string
  }))

  default = [{
    start = "2022-06-01T00:00:00Z",
    end   = "2022-07-01T00:00:00Z"
  }]
  description = "the time period of the budget alert"
}

variable "budget_amount" {
  type        = number
  default     = 100
  description = "amount of the budget"
}

variable "billing_admin_group" {
  type        = string
  default     = "cloudfoundation-billing-admins"
  description = "the name of the cloud foundation billing admin group"
}

variable "billing_reader_group" {
  type        = string
  default     = "cloudfoundation-billing-readers"
  description = "the name of the cloud foundation billing reader group"
}
