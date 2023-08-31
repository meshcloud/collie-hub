---
name: Azure Activity Logs
summary: |
  This module sets up and Azure Log Analytics Workspace and ensures collection of Azure Activity logs in all 
  subscriptions under a management group via policy.
compliance:
  - control: cfmm/security-and-compliance/centralized-audit-logs
    statement: |
      Activates Azure Activity logs in all subscriptions and sends them to a central log analytics workspace for
      storage and analysis.
---

# Activity Log


## Getting started with log analytics workspace

If you have not done so already, move an existing subscription into the management group hierarchy and check the policy assignment status in Azure Portal.
We expect to see that the scope is compliant with the policy.

Here is how you interact with logs in your new workspace.

Open log analytics workspace in Azure portal.
Choose the newly created workspace. 
Choose Workbooks → Activity Logs Insights.
You will see stats about the Activity Logs streamed from the connected subscriptions to the log analytics workspace.
> This assumes that in some Activity Log items has been generated in any of the

Alternatively, you can query logs. To do so, choose Logs in your workspace.

Here is a query that displays the last 50 Activity log events:
```
// Display top 50 Activity log events.
AzureActivity
| project TimeGenerated, SubscriptionId, ResourceGroup,ResourceProviderValue,OperationNameValue,CategoryValue,CorrelationId,ActivityStatusValue, ActivitySubstatusValue, Properties_d, Caller
| top 50 by TimeGenerated
```
  
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | ~> 1.2.26 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.71.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurecaf"></a> [azurecaf](#provider\_azurecaf) | 1.2.26 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.71.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.cafrandom_rg](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_log_analytics_workspace.law](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_management_group_policy_assignment.activity_log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_resource_group.law_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.activity_log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_policy_definition.activity_log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudfoundation_deploy_principal_id"></a> [cloudfoundation\_deploy\_principal\_id](#input\_cloudfoundation\_deploy\_principal\_id) | service principal id | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | location of the resources | `string` | n/a | yes |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | amount of time of log retention | `number` | `30` | no |
| <a name="input_resources_cloudfoundation"></a> [resources\_cloudfoundation](#input\_resources\_cloudfoundation) | tfstate resource group for the statefiles | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | id of the management group that you want to log | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | id of the logging subscription | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assignment_id"></a> [assignment\_id](#output\_assignment\_id) | n/a |
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->
