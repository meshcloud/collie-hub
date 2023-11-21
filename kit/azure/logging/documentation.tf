output "documentation_md" {
  value = <<EOF

# Logging

All actions performed on Azure resources in any subscription are logged in a central [log analytics workspace](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-overview).

This is enforced via an Azure Policy called `${module.policy_law.policy_assignments["Deploy-AzActivity-Log"].display_name}` and can not be deactivated.

## What is being logged?

The log analytics workspace collects Activity Logs, which are [platform logs](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/platform-logs-overview).

## How can I get access?

The kit creates two Groups as preparation for the `Privileged Access Management`.

|group|role|
|-|-|
| cloudfoundation-security-admins | Log Analytics Contributor, Security Admins |
| cloudfoundation-secuirty-readers | Log Analytics Reader, Security Reader |

[Privileged Access Management](https://cloudfoundation.org/maturity-model/iam/privileged-access-management.html#what-is-privileged-access-management-pam)

According to [Azure docs](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/platform-logs-overview#types-of-platform-logs):
> Activity logs provide an insight into the operations performed on each Azure resource in the subscription from the outside, known as the management plane. in addition to updates on Service Health events. Use the Activity log to determine what, who, and when for any write operation (PUT, POST, DELETE) executed on the resources in your subscription. There's a single activity log for each Azure subscription.

## How can I access Activity Logs for my subscription?

You can view Activity Logs for your subscription in Azure portal under [Activity Logs](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/activity-log).

Access to central audit logs is granted on need-to-know basis to Auditors and Cloud Foundation Team members.
EOF
}
