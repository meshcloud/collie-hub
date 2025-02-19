This building block is stateless (no backend) because it's to be used with purge deletion.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_meshstack"></a> [meshstack](#requirement\_meshstack) | >= 0.5.5 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.11.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [meshstack_buildingblock.github_actions_terraform_setup](https://registry.terraform.io/providers/meshcloud/meshstack/latest/docs/resources/buildingblock) | resource |
| [meshstack_tenant.repo](https://registry.terraform.io/providers/meshcloud/meshstack/latest/docs/resources/tenant) | resource |
| [time_sleep.wait](https://registry.terraform.io/providers/hashicorp/time/0.11.1/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_identifier"></a> [project\_identifier](#input\_project\_identifier) | n/a | `string` | n/a | yes |
| <a name="input_workspace_identifier"></a> [workspace\_identifier](#input\_workspace\_identifier) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->