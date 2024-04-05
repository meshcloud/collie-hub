locals {
  contact_emails_list = [
    for x in split(",", var.contact_emails) : trimspace(x)
  ]
}

# Azure requires a startdate in the current month. Changing the start_date of a budget alert
# forces its replacement, so we need to have a "static" time stamp generated at the time of the first apply.
# time_static does just that, so it's the right tool for the job.
resource "time_static" "start_date" {
}

data "azurerm_subscription" "subscription" {
  subscription_id = var.subscription_id
}

resource "azurerm_consumption_budget_subscription" "subscription_budget" {
  name            = var.budget_name
  subscription_id = data.azurerm_subscription.subscription.id

  amount     = var.monthly_budget_amount
  time_grain = "Monthly"

  time_period {
    # azure requires a startdate to be first of the current month
    start_date = formatdate("YYYY-MM-01'T'00:00:00Z", time_static.start_date.rfc3339)
    # end_date: If not set this will be 10 years after the start date.
  }

  notification {
    enabled   = true
    threshold = var.actual_threshold_percent
    operator  = "EqualTo"

    contact_emails = local.contact_emails_list
  }

  notification {
    enabled        = true
    threshold      = var.forcasted_threshold_percent
    operator       = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = local.contact_emails_list
  }
}