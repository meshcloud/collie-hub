output "documentation_md" {
  value = <<EOF
# Logging

All actions performed on Azure resources are logged in a central [log analytics workspace](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-overview).

This is enforced via an Azure Policy called `${module.policy_law.policy_assignments["Deploy-AzActivity-Log"].display_name}` and can not be deactivated.

## What is being logged?

The log analytics workspace collects [Activity Logs](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/activity-log?tabs=powershell).

> Activity logs provide an insight into the operations performed on each Azure resource in the subscription from the outside, known as the management plane. in addition to updates on Service Health events. Use the Activity log to determine what, who, and when for any write operation (PUT, POST, DELETE) executed on the resources in your subscription. There's a single activity log for each Azure subscription.

## How can I access the central log analytics workspace?

Access to central audit logs is granted on need-to-know basis to Auditors and Cloud Foundation Team members.
The following AAD groups control access and are used to implement [Privileged Access Management](./azure-pam.md).

|group|description|object_id|
|-|-|-|
| ${azuread_group.security_admins.display_name} | ${azuread_group.security_admins.description} | ${azuread_group.security_admins.id} |
| ${azuread_group.security_auditors.display_name} | ${azuread_group.security_auditors.description} | ${azuread_group.security_auditors.description} |

## How can I access Activity Logs for my subscription?

Application teams can view Activity Logs for their own subscription in Azure portal under Subscription -> Activity Logs.

EOF
}
