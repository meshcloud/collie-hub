---
name: Azure billing
summary: |
  Set up Azure Cost Management to monitor, allocate, and optimize cost across the entire organization.
compliance:
  - control: cfmm/cost-management/monthly-cloud-tenant-billing-report
    statement: |
      Enables application teams as well as controlling team members to review costs for each subscription.
  - control: cfmm/cost-management/billing-alerts
    statement: |
      Sets up centralized budget alerts monitoring total cloud spend.
---

# Azure Billing

Microsoft Cost Management is a suite of tools that help organizations monitor, allocate, and optimize the cost of their Microsoft Cloud workloads. Cost Management is available to anyone with access to a billing or resource management scope. The availability includes anyone from the cloud finance team with access to the billing account. And, to DevOps teams managing resources in subscriptions and resource groups. Together, Cost Management and Billing are your gateway to the Microsoft Commerce system that’s available to everyone throughout the journey.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.0.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.116.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_group.billing_admins](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/resources/group) | resource |
| [azuread_group.billing_readers](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/resources/group) | resource |
| [azurerm_consumption_budget_management_group.tenant_root_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/consumption_budget_management_group) | resource |
| [azurerm_role_assignment.cost_management_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cost_management_reader](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.management_group_biling_admin](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.management_group_billing_reader](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_admin_group"></a> [billing\_admin\_group](#input\_billing\_admin\_group) | the name of the cloud foundation billing admin group | `string` | `"cloudfoundation-billing-admins"` | no |
| <a name="input_billing_reader_group"></a> [billing\_reader\_group](#input\_billing\_reader\_group) | the name of the cloud foundation billing reader group | `string` | `"cloudfoundation-billing-readers"` | no |
| <a name="input_budget_amount"></a> [budget\_amount](#input\_budget\_amount) | amount of the budget | `number` | `100` | no |
| <a name="input_budget_name"></a> [budget\_name](#input\_budget\_name) | the name of the budget alert | `string` | `"cloudfoundation_budget"` | no |
| <a name="input_budget_time_period"></a> [budget\_time\_period](#input\_budget\_time\_period) | the time period of the budget alert | <pre>list(object({<br>    start = string,<br>    end   = optional(string),<br>  }))</pre> | <pre>[<br>  {<br>    "end": "2022-07-01T00:00:00Z",<br>    "start": "2022-06-01T00:00:00Z"<br>  }<br>]</pre> | no |
| <a name="input_contact_mails"></a> [contact\_mails](#input\_contact\_mails) | The email address of the contact person for the cost alert | `list(string)` | <pre>[<br>  "billingmeshi@meshithesheep.io"<br>]</pre> | no |
| <a name="input_scope"></a> [scope](#input\_scope) | id of the tenant management group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_billing_admins_azuread_group_id"></a> [billing\_admins\_azuread\_group\_id](#output\_billing\_admins\_azuread\_group\_id) | n/a |
| <a name="output_billing_readers_azuread_group_id"></a> [billing\_readers\_azuread\_group\_id](#output\_billing\_readers\_azuread\_group\_id) | n/a |
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->
