variable "scope" {
  type        = string
  nullable    = false
  description = "id of the tenant management group"
}

variable "budget_name" {
  type    = string
  default = "cloudfoundation_budget"
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
  }


variable "budget_amount" {
  type        = number
  default     = 100
  description = "amount of the budget"
}
