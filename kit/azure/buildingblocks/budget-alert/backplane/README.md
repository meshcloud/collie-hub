---
name: Azure Building Block - Subscription Budget Alert
summary: |
  Building block module for adding a simple monthly budget alert to a subscription.
---

# Azure Subscription Budget Alert

This documentation is intended as a reference documentation for cloud foundation or platform engineers using this module.

## Permissions

This is a very simple building block, which means we let the SPN have access to deploy budget alerts
across all subscriptions underneath a management group (typically the top-level management group for landing zones).

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
| [azurerm_role_assignment.buildingblock_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.buildingblock_deploy](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | name of the building block, used for naming resources | `string` | `"budget-alert"` | no |
| <a name="input_principal_ids"></a> [principal\_ids](#input\_principal\_ids) | set of principal ids that will be granted permissions to deploy the building block | `set(string)` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | Scope where the building block should be deployable, typically the parent of all Landing Zones. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | Markdown documentation with information about the Budget Alert building block backplane |
| <a name="output_role_assignment_ids"></a> [role\_assignment\_ids](#output\_role\_assignment\_ids) | The IDs of the role assignments for the service principals. |
| <a name="output_role_assignment_principal_ids"></a> [role\_assignment\_principal\_ids](#output\_role\_assignment\_principal\_ids) | The principal IDs of the service principals that have been assigned the role. |
| <a name="output_role_definition_id"></a> [role\_definition\_id](#output\_role\_definition\_id) | The ID of the role definition that enables deployment of the building block to subscriptions. |
| <a name="output_role_definition_name"></a> [role\_definition\_name](#output\_role\_definition\_name) | The name of the role definition that enables deployment of the building block to subscriptions. |
| <a name="output_scope"></a> [scope](#output\_scope) | The scope where the role definition and role assignments are applied. |
<!-- END_TF_DOCS -->