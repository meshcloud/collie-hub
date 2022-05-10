---
name: Organization Policies
summary: Implements organization-wide policies to remove access to cloud regions and services that are not compliant.
cfmm: 
  - block: security-and-compliance/resource-policies-blacklisting
    description: |
      Blacklist access to non-EU AWS regions.
---
# Organization Policies

Deploys Azure Policies with organization wide effect.

## Writing a policy.json

This terraform module uses ARM `policy.json` definitions for enhanced ease of use.
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_policy_allowed_locations"></a> [policy\_allowed\_locations](#module\_policy\_allowed\_locations) | ../../../util/azure-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_policy_assignment.allowed_locations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_management_group.root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_tenant_id"></a> [aad\_tenant\_id](#input\_aad\_tenant\_id) | Id of the AAD Tenant. This is also the simultaneously the id of the root management group. | `string` | n/a | yes |
| <a name="input_allowed_locations"></a> [allowed\_locations](#input\_allowed\_locations) | Allowed Azure regions. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation"></a> [documentation](#output\_documentation) | n/a |
<!-- END_TF_DOCS -->