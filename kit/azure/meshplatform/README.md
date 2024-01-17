---
name: Azure meshPlatform
summary: |
  integrates this platform with meshStack as a meshPlatform to enable self-service for our engineering teams.
compliance:
  - control: cfmm/tenant-management/cloud-tenant-database
    statement: |
      A cloud tenant database provides clear responsibilities and accountability. Both are crucial to empowering engineering teams with freedom on the cloud.
  - control: cfmm/tenant-management/tenant-provisioning
    statement: |
      Tenant provisioning for the cloud involves the automated allocation and configuration of resources, such as virtual machines and storage, to accommodate specific
      user requirements within a multi-tenant environment.
  - control: cfmm/tenant-management/tenant-deprovisioning-decommisioning
    statement: |
      Establish a process for safely decommissioning and deprovisioning cloud tenants that are no longer needed by application teams.
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
| <a name="module_meshplatform"></a> [meshplatform](#module\_meshplatform) | meshcloud/meshplatform/azure | 0.4.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_permissions"></a> [additional\_permissions](#input\_additional\_permissions) | Additional Subscription-Level Permissions the Service Principal needs. | `list(string)` | `[]` | no |
| <a name="input_additional_required_resource_accesses"></a> [additional\_required\_resource\_accesses](#input\_additional\_required\_resource\_accesses) | Additional AAD-Level Resource Accesses the replicator Service Principal needs. | `list(object({ resource_app_id = string, resource_accesses = list(object({ id = string, type = string })) }))` | `[]` | no |
| <a name="input_metering_assignment_scopes"></a> [metering\_assignment\_scopes](#input\_metering\_assignment\_scopes) | Names or UUIDs of the Management Groups that kraken should collect costs for. | `list(string)` | n/a | yes |
| <a name="input_metering_enabled"></a> [metering\_enabled](#input\_metering\_enabled) | Whether to create Metering Service Principal or not. | `bool` | `true` | no |
| <a name="input_metering_service_principal_name"></a> [metering\_service\_principal\_name](#input\_metering\_service\_principal\_name) | Service principal for collecting cost data. Kraken ist the name of the meshStack component. Name must be unique per Entra ID. | `string` | `"kraken"` | no |
| <a name="input_replicator_assignment_scopes"></a> [replicator\_assignment\_scopes](#input\_replicator\_assignment\_scopes) | Names or UUIDs of the Management Groups which replicator should manage. | `list(string)` | n/a | yes |
| <a name="input_replicator_custom_role_scope"></a> [replicator\_custom\_role\_scope](#input\_replicator\_custom\_role\_scope) | Name or UUID of the Management Group of the replicator custom role definition. The custom role definition must be available for all assignment scopes. | `string` | `"Tenant Root Group"` | no |
| <a name="input_replicator_enabled"></a> [replicator\_enabled](#input\_replicator\_enabled) | Whether to create replicator Service Principal or not. | `bool` | `true` | no |
| <a name="input_replicator_rg_enabled"></a> [replicator\_rg\_enabled](#input\_replicator\_rg\_enabled) | Whether the created replicator Service Principal should be usable for Azure Resource Group based replication. Implicitly enables replicator\_enabled if set to true. | `bool` | `false` | no |
| <a name="input_replicator_service_principal_name"></a> [replicator\_service\_principal\_name](#input\_replicator\_service\_principal\_name) | Service principal for managing subscriptions. Replicator is the name of the meshStack component. Name must be unique per Entra ID. | `string` | `"replicator"` | no |
| <a name="input_sso_enabled"></a> [sso\_enabled](#input\_sso\_enabled) | Whether to create SSO Service Principal or not. | `bool` | `true` | no |
| <a name="input_sso_meshstack_redirect_uri"></a> [sso\_meshstack\_redirect\_uri](#input\_sso\_meshstack\_redirect\_uri) | Redirect URI that was provided by meshcloud. It is individual per meshStack. | `string` | `""` | no |
| <a name="input_sso_service_principal_name"></a> [sso\_service\_principal\_name](#input\_sso\_service\_principal\_name) | Service principal for Entra ID SSO. Name must be unique per Entra ID. | `string` | `"sso"` | no |

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
<!-- END_TF_DOCS -->
