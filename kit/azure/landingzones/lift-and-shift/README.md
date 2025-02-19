---
name: Azure Landing Zone "Lift & Shift"
summary: |
  An already existing Azure subscription that is a landing zone for migrating lift & shift workload
---

# Azure Landing Zone "Lift & Shift"

This kit provides a Terraform configuration for managing an Azure subscription that will be used as a landing zone for lift & shift workloads.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.116.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_subscription_association.lift_and_shift](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/management_group_subscription_association) | resource |
| [terraform_data.subscription_name](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lift_and_shift_subscription_name"></a> [lift\_and\_shift\_subscription\_name](#input\_lift\_and\_shift\_subscription\_name) | The name the subscription should be renamed to. | `string` | n/a | yes |
| <a name="input_parent_management_group_id"></a> [parent\_management\_group\_id](#input\_parent\_management\_group\_id) | The ID of the management group to associate the subscription with. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_lift_and_shift_subscription_id"></a> [lift\_and\_shift\_subscription\_id](#output\_lift\_and\_shift\_subscription\_id) | n/a |
<!-- END_TF_DOCS -->