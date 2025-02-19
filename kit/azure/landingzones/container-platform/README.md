---
name: Azure Landing Zone "Container-Platform"
summary: |
  deploys new cloud foundation infrastructure.
  Add a concise description of the module's purpose here.
compliance:
- control: cfmm/tenant-management/container-platform-landing-zone
  statement: |
    Restricts the list of permitted Azure services in relation to container Container-Platform.
---

# Azure Landing Zone "Container-Platform"

The Container Platform Landing Zone is a pre-configured environment designed to support the deployment and management of containerized applications at scale. It provides a foundation for running container workloads using services like Azure Kubernetes Service (AKS) and Azure Container Instances (ACI).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.116.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_policy_container_platform"></a> [policy\_container\_platform](#module\_policy\_container\_platform) | github.com/meshcloud/collie-hub//kit/azure/util/azure-policies | 7c356a7 |
| <a name="module_policy_container_platform_dev"></a> [policy\_container\_platform\_dev](#module\_policy\_container\_platform\_dev) | github.com/meshcloud/collie-hub//kit/azure/util/azure-policies | 7c356a7 |
| <a name="module_policy_container_platform_prod"></a> [policy\_container\_platform\_prod](#module\_policy\_container\_platform\_prod) | github.com/meshcloud/collie-hub//kit/azure/util/azure-policies | 7c356a7 |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.container_platform](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/management_group) | resource |
| [azurerm_management_group.dev](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/management_group) | resource |
| [azurerm_management_group.prod](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/management_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The Azure location where this policy assignment should exist, required when an Identity is assigned. | `string` | `"germanywestcentral"` | no |
| <a name="input_lz-container-platform"></a> [lz-container-platform](#input\_lz-container-platform) | n/a | `string` | `"container-platform"` | no |
| <a name="input_parent_management_group_id"></a> [parent\_management\_group\_id](#input\_parent\_management\_group\_id) | The tenant management group of your cloud foundation | `string` | `"foundation"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dev_management_display_name"></a> [dev\_management\_display\_name](#output\_dev\_management\_display\_name) | n/a |
| <a name="output_dev_management_id"></a> [dev\_management\_id](#output\_dev\_management\_id) | n/a |
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_management_display_name"></a> [management\_display\_name](#output\_management\_display\_name) | n/a |
| <a name="output_management_id"></a> [management\_id](#output\_management\_id) | n/a |
| <a name="output_policy_container_platform_assignments"></a> [policy\_container\_platform\_assignments](#output\_policy\_container\_platform\_assignments) | n/a |
| <a name="output_policy_container_platform_dev_assignments"></a> [policy\_container\_platform\_dev\_assignments](#output\_policy\_container\_platform\_dev\_assignments) | n/a |
| <a name="output_policy_container_platform_prod_assignments"></a> [policy\_container\_platform\_prod\_assignments](#output\_policy\_container\_platform\_prod\_assignments) | n/a |
| <a name="output_prod_management_display_name"></a> [prod\_management\_display\_name](#output\_prod\_management\_display\_name) | n/a |
| <a name="output_prod_management_id"></a> [prod\_management\_id](#output\_prod\_management\_id) | n/a |
<!-- END_TF_DOCS -->
