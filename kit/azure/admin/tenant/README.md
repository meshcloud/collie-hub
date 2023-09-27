---
name: Azure Tenant Configuration
summary: |
  Applies AAD tenant-level configuration
compliance:
---

# Azure Tenant Configuration

In Azure, the AAD tenant is its own concept.

::: tip
Keep in mind that every tenant has a "root management group", sitting at the top of the management group hierarchy.
The `id` of this management group is equal to the AAD tenant id.
:::

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.71.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_billing_admins"></a> [billing\_admins](#module\_billing\_admins) | ./billing-admins | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_tenant_id"></a> [aad\_tenant\_id](#input\_aad\_tenant\_id) | Id of the AAD Tenant. This is also the simultaneously the id of the root management group. | `string` | n/a | yes |
| <a name="input_billing_users"></a> [billing\_users](#input\_billing\_users) | The list of users identified by their UPN that shall be granted billing access | <pre>list(object({<br>    email = string,<br>    upn   = string,<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->
