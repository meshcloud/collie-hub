---
name: Azure billing
summary: |
  This kit is designed to help organizations monitor, allocate, and optimize the cost of their Microsoft cloud workloads.
compliance:
  - control: cfmm/cost-management
    statement: |
      The kit creates groupus to manage the cost management and view the expenses through the cloud foundation.
---

# Azure Billing

Microsoft Cost Management is a suite of tools that help organizations monitor, allocate, and optimize the cost of their Microsoft Cloud workloads. Cost Management is available to anyone with access to a billing or resource management scope. The availability includes anyone from the cloud finance team with access to the billing account. And, to DevOps teams managing resources in subscriptions and resource groups. Together, Cost Management and Billing are your gateway to the Microsoft Commerce system that’s available to everyone throughout the journey.


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_group.billing_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group.billing_readers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azurerm_consumption_budget_management_group.tenant_root_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_management_group) | resource |
| [azurerm_role_assignment.cost_management_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cost_management_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.management_group_biling_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.management_group_billing_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_admin_group"></a> [billing\_admin\_group](#input\_billing\_admin\_group) | the name of the cloud foundation billing admin group | `string` | `"cloudfoundation-billing-admins"` | no |
| <a name="input_billing_reader_group"></a> [billing\_reader\_group](#input\_billing\_reader\_group) | the name of the cloud foundation billing reader group | `string` | `"cloudfoundation-billing-readers"` | no |
| <a name="input_budget_amount"></a> [budget\_amount](#input\_budget\_amount) | amount of the budget | `number` | `100` | no |
| <a name="input_budget_name"></a> [budget\_name](#input\_budget\_name) | the name of the budget alert | `string` | `"cloudfoundation_budget"` | no |
| <a name="input_budget_time_period"></a> [budget\_time\_period](#input\_budget\_time\_period) | the time period of the budget alert | <pre>list(object({<br>    start = string,<br>    end   = string<br>  }))</pre> | <pre>[<br>  {<br>    "end": "2022-07-01T00:00:00Z",<br>    "start": "2022-06-01T00:00:00Z"<br>  }<br>]</pre> | no |
| <a name="input_contact_mails"></a> [contact\_mails](#input\_contact\_mails) | The email address of the contact person for the cost alert | `list(string)` | <pre>[<br>  "billingmeshi@meshithesheep.io"<br>]</pre> | no |
| <a name="input_scope"></a> [scope](#input\_scope) | id of the tenant management group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_billing_admins_azuread_group_displayname"></a> [billing\_admins\_azuread\_group\_displayname](#output\_billing\_admins\_azuread\_group\_displayname) | n/a |
| <a name="output_billing_admins_azuread_group_id"></a> [billing\_admins\_azuread\_group\_id](#output\_billing\_admins\_azuread\_group\_id) | n/a |
| <a name="output_billing_readers_azuread_group_displayname"></a> [billing\_readers\_azuread\_group\_displayname](#output\_billing\_readers\_azuread\_group\_displayname) | n/a |
| <a name="output_billing_readers_azuread_group_id"></a> [billing\_readers\_azuread\_group\_id](#output\_billing\_readers\_azuread\_group\_id) | n/a |
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->
