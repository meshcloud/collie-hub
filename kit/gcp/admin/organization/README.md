---
name: GCP Organization Setup
summary: |
  configures organization wide policies.
---

# GCP Organization Setup

This documentation is intended as a reference documentation for cloud foundation or platform engineers using this module.
  
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.80.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_allowed-policy-member-domains"></a> [allowed-policy-member-domains](#module\_allowed-policy-member-domains) | terraform-google-modules/org-policy/google | ~> 5.1.0 |
| <a name="module_allowed-policy-resource-locations"></a> [allowed-policy-resource-locations](#module\_allowed-policy-resource-locations) | terraform-google-modules/org-policy/google | ~> 5.1.0 |

## Resources

| Name | Type |
|------|------|
| [google_organization.orgs](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/organization) | data source |
| [google_project.foundation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_ids_to_allow"></a> [customer\_ids\_to\_allow](#input\_customer\_ids\_to\_allow) | The list of Google Customer Ids to allow users from. | <pre>list(object(<br>    {<br>      domain      = string<br>      customer_id = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_domains_to_allow"></a> [domains\_to\_allow](#input\_domains\_to\_allow) | The list of domains to allow users from. This list is concatenated to customer\_ids\_to\_allow | `list(string)` | n/a | yes |
| <a name="input_resource_locations_to_allow"></a> [resource\_locations\_to\_allow](#input\_resource\_locations\_to\_allow) | The list of resource locations to allow | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->