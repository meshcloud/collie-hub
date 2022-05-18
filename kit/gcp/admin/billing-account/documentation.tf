variable "output_md_file" {
  type        = string
  description = "location of the file where this cloud foundation kit module generates its documentation output"
}

resource "local_file" "output_md" {
  filename = var.output_md_file
  # tip: 
  # pro-tip: you can 
  content = <<EOF

The billing account used in this platform is called `${data.google_billing_account.account.name}`and has id `${data.google_billing_account.account.id}`.

### Billing Administrator

tbd.

EOF
}
