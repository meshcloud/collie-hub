---
name: Azure Landing Zone "Cloud-Native"
summary: |
compliance:
- control: cfmm/cloud-native-landing-zone
  statement: |
    A dedicated landing zone optimized for cloud-native workloads enables quick
    onboarding and efficient operations.
---

# Azure Landing Zone "Cloud-Native"

 Cloud Native Landing Zone is a purpose-built environment in the cloud designed to streamline the development, deployment,
 and operation of applications. It incorporates automation, security measures, and best practices for cloud-native development
 to ensure efficient and secure utilization of cloud resources.

The kit will create a dev group and a prod management groups.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.71.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.cloudnative](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | name of the landing zone's management group | `string` | `"cloudnative"` | no |
| <a name="input_parent_management_group_id"></a> [parent\_management\_group\_id](#input\_parent\_management\_group\_id) | id of the parent management group for the landing zone's management group | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->
