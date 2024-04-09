resource "azurerm_consumption_budget_management_group" "tenant_root_group" {
  name                = var.budget_name
  management_group_id = var.scope

  amount     = var.budget_amount
  time_grain = "Monthly"

  time_period {
    start_date = var.budget_time_period[0].start
    end_date   = var.budget_time_period[0].end
  }

  notification {
    enabled   = true
    threshold = 90.0
    operator  = "EqualTo"

    contact_emails = var.contact_mails
  }

  notification {
    enabled        = false
    threshold      = 100.0
    operator       = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = var.contact_mails
  }
}
