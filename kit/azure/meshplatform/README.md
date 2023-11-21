---
name: Azure meshPlatform
summary: |
  integrates this platform with meshStack as a meshPlatform to enable self-service for our engineering teams.
compliance:
  - control: cfmm/tenant-management/cloud-tenant-database
    statement: |
  - control: cfmm/tenant-management/tenant-provisioning
    statement: |
  - control: cfmm/tenant-management/tenant-deprovisioning-decommisioning
    statement: |
  - control: cfmm/tenant-management/multi-cloud-tenant-database-integrated-with-lifecycle-management
    statement: |
      A central database of all multi-cloud tenants initiates tenant provisioning and deprovisioning processes. The database acts as an authoritative source of tenants and ensures tenant metadata is always up to date.
---

# Azure meshPlatform

This kit module integrates Azure into meshStack as a platform using the official terraform-azure-meshplatform module. This module sets up service principals and permissions required for meshStack.
The output of this module is a set of credentials that need to be configured in meshStack as described in [meshcloud public docs](https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform.html).

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_meshplatform"></a> [meshplatform](#module\_meshplatform) | meshcloud/meshplatform/azure | 0.3.2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_permissions"></a> [additional\_permissions](#input\_additional\_permissions) | Additional Subscription-Level Permissions the Service Principal needs. | `list(string)` | `[]` | no |
| <a name="input_additional_required_resource_accesses"></a> [additional\_required\_resource\_accesses](#input\_additional\_required\_resource\_accesses) | Additional AAD-Level Resource Accesses the replicator Service Principal needs. | `list(object({ resource_app_id = string, resource_accesses = list(object({ id = string, type = string })) }))` | `[]` | no |
| <a name="input_idplookup_enabled"></a> [idplookup\_enabled](#input\_idplookup\_enabled) | Whether to create idplookup Service Principal or not. | `bool` | `true` | no |
| <a name="input_kraken_enabled"></a> [kraken\_enabled](#input\_kraken\_enabled) | Whether to create kraken Service Principal or not. | `bool` | `true` | no |
| <a name="input_mgmt_group_name"></a> [mgmt\_group\_name](#input\_mgmt\_group\_name) | The name or UUID of the Management Group. | `string` | n/a | yes |
| <a name="input_replicator_enabled"></a> [replicator\_enabled](#input\_replicator\_enabled) | Whether to create replicator Service Principal or not. | `bool` | `true` | no |
| <a name="input_service_principal_name_suffix"></a> [service\_principal\_name\_suffix](#input\_service\_principal\_name\_suffix) | Service principal name suffix. Make sure this is unique. | `string` | n/a | yes |
| <a name="input_subscriptions"></a> [subscriptions](#input\_subscriptions) | The scope to which UAMI blueprint service principal role assignment is applied. | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_ad_tenant_id"></a> [azure\_ad\_tenant\_id](#output\_azure\_ad\_tenant\_id) | The Azure AD tenant id. |
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_meshplatform"></a> [meshplatform](#output\_meshplatform) | n/a |
| <a name="output_metering_client_secret"></a> [metering\_client\_secret](#output\_metering\_client\_secret) | Password for Metering Service Principal. |
| <a name="output_metering_credentials"></a> [metering\_credentials](#output\_metering\_credentials) | Metering Service Principal. |
| <a name="output_replicator_client_secret"></a> [replicator\_client\_secret](#output\_replicator\_client\_secret) | Password for Replicator Service Principal. |
| <a name="output_replicator_credentials"></a> [replicator\_credentials](#output\_replicator\_credentials) | Replicator Service Principal. |
| <a name="output_uami_blueprint_user_principal"></a> [uami\_blueprint\_user\_principal](#output\_uami\_blueprint\_user\_principal) | UAMI Blueprint Assignment Service Principal. |
| <a name="output_uami_blueprint_user_principal_password"></a> [uami\_blueprint\_user\_principal\_password](#output\_uami\_blueprint\_user\_principal\_password) | Password for UAMI Blueprint Assignment Service Principal. |
<!-- END_TF_DOCS -->
