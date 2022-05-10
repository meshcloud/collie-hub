output "documentation" {
  value = <<EOF
### Billing Admins

The following users have the [${local.policy_arn}](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_job-functions.html#jf_accounts-payable)
on the root account.

${join("\n", formatlist("- %s (principal id `%s`)", var.billing_users[*].email, var.billing_users[*].principal_id))}
EOF
}
