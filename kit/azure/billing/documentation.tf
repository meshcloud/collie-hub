output "documentation_md" {
  value = <<EOF

# Billing

It is recommended to use payment methods such as credit cards and invoices to ensure that you can access your Azure resources at any time.
The kit provides a first-of-its-kind cost alert for the entire Cloud Foundation.

## Who is informed about costs?

The following people will be notified when the established cost limit is exceeded:
 ${join("\n", formatlist("- %s", var.contact_mails))}

## How I can get access?

The kit creates two Groups as preparation for the Privileged Access Mananganmet.

|group|role|
|-|-|
| cloudfoundation-billing-admins | Cost Management Contributor, Management Group Reader |
| cloudfoundation-billing-readers | Cost Management Reader, Management Group Reader |

[Privileged Access Mananganmet](https://cloudfoundation.org/maturity-model/iam/privileged-access-management.html#what-is-privileged-access-management-pam)

EOF
}
