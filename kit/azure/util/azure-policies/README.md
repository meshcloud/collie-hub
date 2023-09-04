# Policies Helper Module

A small utility module that helps deploying policy definitions, policy sets and policy assignments from
Azure Policy JSON files.

These files are compatible with Azure Enterprise Scale examples as well as Azure built-in policies, providing
a great starting point for quickly adding existing policies to your landing zones.

> The code in this module is conceptually based on [Azure CAF Enterprise Scale Terraform](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/tree/main/modules/archetypes/lib).

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_policy_assignment.enterprise_scale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_policy_definition.enterprise_scale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |
| [azurerm_policy_set_definition.enterprise_scale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | location for the policy assignment | `string` | n/a | yes |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | The management group scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | path of the json policies, sets or assignments | `string` | n/a | yes |
| <a name="input_template_file_variables"></a> [template\_file\_variables](#input\_template\_file\_variables) | variables for *.tmpl.json files, expanded with terraform templatefile() function | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_assignments"></a> [policy\_assignments](#output\_policy\_assignments) | n/a |
| <a name="output_policy_definitions"></a> [policy\_definitions](#output\_policy\_definitions) | n/a |
| <a name="output_policy_sets"></a> [policy\_sets](#output\_policy\_sets) | n/a |
<!-- END_TF_DOCS -->