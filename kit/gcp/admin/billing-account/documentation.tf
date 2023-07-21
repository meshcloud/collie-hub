output "documentation_md" {
  value = <<EOF

The billing account used in this platform is called `${data.google_billing_account.account.name}`and has id `${data.google_billing_account.account.id}`.

### Billing Administrator

tbd.

EOF
}
