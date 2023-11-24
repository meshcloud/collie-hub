---
name: Azure Landing Zone "sandbox"
summary: |
  A sandbox landing zone in Azure is essentially a controlled and isolated space where users can deploy and test
  various resources, applications, and configurations without affecting the production environment.
compliance:
- control: cfmm/tenant-management/playground-sandbox-environments
  statement: |
    It's a best practice for development, testing, and learning purposes, providing a safe and secure area to explore Azure services
    and features. This allows users to gain hands-on experience without the risk of impacting critical systems.
---

# Azure Landing Zone "sandbox"

This kit provides a Terraform configuration for setting up Azure Management Groups for dedicated Management Group and policy for sandbox Landingzones.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_policy_sandbox"></a> [policy\_sandbox](#module\_policy\_sandbox) | github.com/meshcloud/collie-hub//kit/azure/util/azure-policies | ef06c8d |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.sandbox](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |

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
