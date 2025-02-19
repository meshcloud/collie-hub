output "documentation_md" {
  value = <<EOF
# Billing

We use [Azure Cost Management](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/overview-cost-management)
to monitor our total cloud spend and manage the billing and invoicing process with Microsoft.

## Spend Monitoring

We perform global spend monitoring for our entire Azure cloud spend.

The following people will be notified when the established cost limit is exceeded:
 ${join("\n", formatlist("- %s", var.contact_mails))}

## How I can get access?

Access to cost management data is granted on need-to-know basis to Auditors, members of Controlling and Cloud Foundation Team members.

The following AAD groups control access and are used to implement [Privileged Access Management](./azure-pam.md).

|group|description|object_id|
|-|-|-|
| ${azuread_group.billing_admins.display_name} | ${azuread_group.billing_admins.description} | ${azuread_group.billing_admins.object_id} |
| ${azuread_group.billing_readers.display_name} | ${azuread_group.billing_readers.description} | ${azuread_group.billing_readers.object_id} |

## How can I review Cost Management data for my subscription

Application teams can view Cost Management data for their own subscription in Azure portal under Subscription -> Cost Management.

EOF
}
