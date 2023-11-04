output "documentation_md" {
  value = <<EOF

It is recommended to use payment methods such as credit cards and invoices to ensure that you can access your Azure resources at any time. 
The kit provides a first-of-its-kind cost alert for the entire Cloud Foundation.

The kit creates two Groups as preparation for the Privileged Access Mananganmet.

| group                           | role                      |
---------------------------------------------------------------
| cloudfoundation-billing-admins | Cost Management Contributor, Management Group Reader |
| cloudfoundation-billing-readers | Cost Management Reader, Management Group Reader |

[Privileged Access Mananganmet](https://cloudfoundation.org/maturity-model/iam/privileged-access-management.html#what-is-privileged-access-management-pam)

TODO: describe the deployed resources and its configuration in a human-friendly way.

EOF
}
