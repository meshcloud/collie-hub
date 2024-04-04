# terraform test is cool because it does the apply and destroy lifecycle
# what it doesn't test though is the backend storage. if we want to test that, we need to that via terragrunt

run "verify" {
  variables {
    budget_name           = "integrationtest"
    contact_emails        = "foo@example.com, bar@example.com"
    monthly_budget_amount = 100
  }

  assert {
    condition     = output.budget_amount == 100
    error_message = "did not produce the correct budget_amount output"
  }

  assert {
    # have to do some type conversion magic here to fix issues of tups vs. lists vs. sets
    condition = jsonencode(
      distinct([
        for x in azurerm_consumption_budget_subscription.subscription_budget.notification : x.contact_emails
      ])
    ) == jsonencode([["foo@example.com", "bar@example.com"]])
    error_message = "incorrect alert recipients"
  }
}