---
name: Azure Landing Zone "Corp-Online"
summary: |
  deploys new cloud foundation infrastructure.
  Add a concise description of the module's purpose here.
# optional: add additional metadata about implemented security controls
---

# Azure Landing Zone "Corp-Online"

This documentation is intended as a reference documentation for cloud foundation or platform engineers using this module.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_policy_serverless"></a> [policy\_serverless](#module\_policy\_serverless) | github.com/meshcloud/collie-hub//kit/azure/util/azure-policies | ef06c8d |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.serverless](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_landingzones"></a> [landingzones](#input\_landingzones) | The parent\_management\_group where your landingzones are | `string` | `"lv-landingzones"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location where this policy assignment should exist, required when an Identity is assigned. | `string` | `"germanywestcentral"` | no |
| <a name="input_lz-serverless"></a> [lz-serverless](#input\_lz-serverless) | n/a | `string` | `"serverless"` | no |
| <a name="input_parent_management_group_id"></a> [parent\_management\_group\_id](#input\_parent\_management\_group\_id) | The tenant management group of your cloud foundation | `string` | `"lv-foundation"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_management_id"></a> [management\_id](#output\_management\_id) | n/a |
<!-- END_TF_DOCS -->
