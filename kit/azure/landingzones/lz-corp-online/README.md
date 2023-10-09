---
name: Azure Landing Zone "Corp-Online"
summary: |
  deploys the parent Management Group for Corp/Online Landingzones.
compliance:
- control: cfmm/security-and-compliance/service-and-location-restrictions
  statement: |
    Restricts deployment of vWAN/ER/VPN gateway resources in the Corp landing zone
    Restricts creation of Azure PaaS services with exposed public endpoints
    Restricts network interfaces from having a public IP associated to it under the assigned scope
- control: cfmm/security-and-compliance/centralized-audit-logs
  statement: |
      Audits the deployment of Private Link Private DNS Zone resources in the Corp landing zone.
---

# Azure Landing Zone "Corp-Online"

This kit provides a Terraform configuration for setting up Azure Management Groups for dedicated Management Group for Online and Corp landing zones, meaning workloads that may require direct internet inbound/outbound connectivity or also for workloads that may not require a VNet will live in Online. Landingzones which requires connectivity/hybrid connectivity with the corporate network thru the hub in the connectivity subscription will live on Corp.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_policy_corp"></a> [policy\_corp](#module\_policy\_corp) | github.com/meshcloud/collie-hub//kit/azure/util/azure-policies | ef06c8d |
| <a name="module_policy_online"></a> [policy\_online](#module\_policy\_online) | github.com/meshcloud/collie-hub//kit/azure/util/azure-policies | ef06c8d |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.corp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.online](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudfoundation"></a> [cloudfoundation](#input\_cloudfoundation) | the name of your cloudfoundation | `string` | n/a | yes |
| <a name="input_corp"></a> [corp](#input\_corp) | n/a | `string` | `"corp"` | no |
| <a name="input_landingzones"></a> [landingzones](#input\_landingzones) | The parent\_management\_group where your landingzones are | `string` | `"lv-landingzones"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location where this policy assignment should exist, required when an Identity is assigned. | `string` | `"germanywestcentral"` | no |
| <a name="input_online"></a> [online](#input\_online) | n/a | `string` | `"online"` | no |
| <a name="input_parent_management_group_id"></a> [parent\_management\_group\_id](#input\_parent\_management\_group\_id) | The tenant management group of your cloud foundation | `string` | `"lv-foundation"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_corp_id"></a> [corp\_id](#output\_corp\_id) | n/a |
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_online_id"></a> [online\_id](#output\_online\_id) | n/a |
<!-- END_TF_DOCS -->
