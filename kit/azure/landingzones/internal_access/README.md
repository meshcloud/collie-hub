---
name: Azure Landing Zone "Internal Access"
summary: |
  deploys new cloud foundation infrastructure.
  Add a concise description of the module's purpose here.
# optional: add additional metadata about implemented security controls
---

# Azure Landing Zone "Internal Access"

This documentation is intended as a reference documentation for cloud foundation or platform engineers using this module.
  
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.71.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.71.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.internal_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group_policy_assignment.no_public_ips](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_policy_definition.no_public_ips](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_parent_management_group_id"></a> [parent\_management\_group\_id](#input\_parent\_management\_group\_id) | id of the parent management group for this landing zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->