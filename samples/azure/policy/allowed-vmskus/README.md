---
name: Allowed VM SKUs
summary: |
  deploys new cloud foundation infrastructure.
  Add a concise description of the module's purpose here.
# optional: add additional metadata about implemented security controls
compliance:
  - control: cfmm/allowed-vmskus
    statement: |
      Activates Azure Activity logs in all subscriptions and sends them to a central log analytics workspace for
      storage and analysis.
---

# Allowed VM SKUs

This documentation is intended as a reference documentation for cloud foundation or platform engineers using this module.
  
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_policy_assignment.allowed_vm_skus](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [local_file.output_md](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_policy_definition.allowed_vm_skus](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_listofallowedvmskus"></a> [listofallowedvmskus](#input\_listofallowedvmskus) | List of allowed VM SKUs | `list()` | `"Basic_A1"` | no |
| <a name="input_output_md_file"></a> [output\_md\_file](#input\_output\_md\_file) | location of the file where this cloud foundation kit module generates its documentation output | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->