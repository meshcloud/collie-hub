---
name: Azure Organization Hierarchy
summary: |
  deploys the Azure Organization Hierarchy.
---

# Azure Organization Hierarchy

This repository provides a Terraform configuration for setting up Azure Management Groups in alignment with the Azure Enterprise Scale Cloud Adoption Framework (CAF). The management groups enable efficient management, access control, and policy enforcement across multiple Azure subscriptions.

## Overview

The Terraform configuration in this repository establishes a hierarchical structure of management groups to organize and govern Azure resources effectively. The configuration follows the principles of the Azure Enterprise Scale CAF to provide a scalable and standardized approach to managing your Azure environment.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.connectivity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.corp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.landingzones](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.management](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.online](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.parent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group_subscription_association.management](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connectivity"></a> [connectivity](#input\_connectivity) | n/a | `string` | `"lv-connectivity"` | no |
| <a name="input_corp"></a> [corp](#input\_corp) | n/a | `string` | `"lv-corp"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | n/a | `string` | `"lv-identity"` | no |
| <a name="input_landingzones"></a> [landingzones](#input\_landingzones) | n/a | `string` | `"lv-landingzones"` | no |
| <a name="input_management"></a> [management](#input\_management) | n/a | `string` | `"lv-management"` | no |
| <a name="input_online"></a> [online](#input\_online) | n/a | `string` | `"lv-online"` | no |
| <a name="input_parentManagementGroup"></a> [parentManagementGroup](#input\_parentManagementGroup) | n/a | `string` | `"lv-foundation"` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | n/a | `string` | `"lv-platform"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connectivity_id"></a> [connectivity\_id](#output\_connectivity\_id) | n/a |
| <a name="output_corp_id"></a> [corp\_id](#output\_corp\_id) | n/a |
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_identity_id"></a> [identity\_id](#output\_identity\_id) | n/a |
| <a name="output_landingzones_id"></a> [landingzones\_id](#output\_landingzones\_id) | n/a |
| <a name="output_management_id"></a> [management\_id](#output\_management\_id) | n/a |
| <a name="output_online_id"></a> [online\_id](#output\_online\_id) | n/a |
| <a name="output_parent_id"></a> [parent\_id](#output\_parent\_id) | n/a |
| <a name="output_platform_id"></a> [platform\_id](#output\_platform\_id) | n/a |
<!-- END_TF_DOCS -->
