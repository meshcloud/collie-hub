# Enable billing admins via AWS SSO to access billing data on the organization root account
locals {
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

resource "aws_ssoadmin_permission_set" "billing" {
  name             = "adminBillingAccess"
  description      = "Provides access to AWS Billing Dashboard"
  instance_arn     = var.aws_sso_instance_arn
  relay_state      = "https://console.aws.amazon.com/billing/home?region=eu-central-1#/"
  session_duration = "PT12H"
}

resource "aws_ssoadmin_managed_policy_attachment" "billing" {
  instance_arn       = var.aws_sso_instance_arn
  managed_policy_arn = local.policy_arn
  permission_set_arn = aws_ssoadmin_permission_set.billing.arn
}

resource "aws_ssoadmin_account_assignment" "billing_users" {
  for_each           = toset(var.billing_users[*].principal_id)
  instance_arn       = aws_ssoadmin_permission_set.billing.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.billing.arn

  principal_id   = each.key
  principal_type = "USER"

  target_id   = var.aws_root_account_id
  target_type = "AWS_ACCOUNT"
}

