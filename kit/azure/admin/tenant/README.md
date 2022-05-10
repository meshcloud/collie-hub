---
name: Azure Tenant Configuration
summary: |
  applies AAD tenant-level configuration. This includes organization policies and other key settings affecting
  all cloud infrastructure in this tenant.
compliance:
- control: compliance/cfmm/security-and-compliance/resource-policies-blacklisting
  statement: |
    A service control policy denies access to any non-EU Azure regions.
---

# Azure Tenant Configuration

In Azure, the AAD tenant is its own concept.

::: tip
Keep in mind that every tenant has a "root management group", sitting at the top of the management group hierarchy.
The `id` of this management group is equal to the AAD tenant id.
:::
c

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_billing_admins"></a> [billing\_admins](#module\_billing\_admins) | ./billing-admins | n/a |
| <a name="module_organization_policies"></a> [organization\_policies](#module\_organization\_policies) | ./organization-policies | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.output_md](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_tenant_id"></a> [aad\_tenant\_id](#input\_aad\_tenant\_id) | Id of the AAD Tenant. This is also the simultaneously the id of the root management group. | `string` | n/a | yes |
| <a name="input_allowed_locations"></a> [allowed\_locations](#input\_allowed\_locations) | Allowed Azure regions. | `list(string)` | <pre>[<br>  "westeurope",<br>  "northeurope",<br>  "germany",<br>  "germanywestcentral",<br>  "europe"<br>]</pre> | no |
| <a name="input_billing_users"></a> [billing\_users](#input\_billing\_users) | The list of users identified by their UPN that shall be granted billing access | <pre>list(object({<br>    email = string,<br>    upn = string,<br>  }))</pre> | `[]` | no |
| <a name="input_output_md_file"></a> [output\_md\_file](#input\_output\_md\_file) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->