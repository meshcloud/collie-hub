---
name: Azure network
summary: |
  compliance:
  - control: cfmm/cost-management/monthly-cloud-tenant-billing-report
    statement: |
      Enables application teams as well as controlling team members to review costs for each subscription.
  - control: cfmm/cost-management/billing-alerts
    statement: |
      Sets up centralized budget alerts monitoring total cloud spend.
---

# Azure network

Microsoft Cost Management is a suite of tools that help organizations monitor, allocate, and optimize the cost of their Microsoft Cloud workloads. Cost Management is available to anyone with access to a billing or resource management scope. The availability includes anyone from the cloud finance team with access to the billing account. And, to DevOps teams managing resources in subscriptions and resource groups. Together, Cost Management and Billing are your gateway to the Microsoft Commerce system that’s available to everyone throughout the journey.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.41.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.85.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_group.network_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azurerm_firewall.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |
| [azurerm_monitor_diagnostic_setting.fw_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_ddos_protection_plan.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_ddos_protection_plan) | resource |
| [azurerm_network_security_group.mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_watcher.netwatcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher) | resource |
| [azurerm_network_watcher_flow_log.mgmt_logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_public_ip.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.fw_mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip_prefix.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix) | resource |
| [azurerm_resource_group.hub_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.netwatcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.cloudfoundation_tfdeploy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cloudfoundation_tfdeploy_lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.network_admins](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.network_admins_dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.network_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.network_contributor_lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.cloudfoundation_tfdeploy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_role_definition.cloudfoundation_tfdeploy_lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_route_table.out](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_storage_account.flowlogs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.flowlogs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_subnet.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.firewallmgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subscription.networking](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription) | resource |
| [azurerm_virtual_network.hub_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [random_string.dns](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_monitor_diagnostic_categories.fw_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | List of address spaces for the virtual networks | `string` | n/a | yes |
| <a name="input_cloudfoundation"></a> [cloudfoundation](#input\_cloudfoundation) | this is the name of your cloud foundation | `string` | n/a | yes |
| <a name="input_cloudfoundation_deploy_principal_id"></a> [cloudfoundation\_deploy\_principal\_id](#input\_cloudfoundation\_deploy\_principal\_id) | Principal ID for deploying Cloud Foundation resources | `string` | n/a | yes |
| <a name="input_create_ddos_plan"></a> [create\_ddos\_plan](#input\_create\_ddos\_plan) | Create a DDos protection plan and attach to vnet. | `bool` | `false` | no |
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | Diagnostic settings for those resources that support it. See README.md for details on configuration. | <pre>object({<br>    destination = string<br>    logs        = list(string)<br>    metrics     = list(string)<br>  })</pre> | `null` | no |
| <a name="input_firewall_bool"></a> [firewall\_bool](#input\_firewall\_bool) | firewall off | `bool` | `false` | no |
| <a name="input_firewall_sku_tier"></a> [firewall\_sku\_tier](#input\_firewall\_sku\_tier) | Basic, Standard ... | `string` | `"Standard"` | no |
| <a name="input_firewall_zones"></a> [firewall\_zones](#input\_firewall\_zones) | A collection of availability zones to spread the Firewall over. | `list(string)` | `null` | no |
| <a name="input_hub_networking_deploy"></a> [hub\_networking\_deploy](#input\_hub\_networking\_deploy) | Service Principal responsible for deploying the hub networking | `string` | `"cloudfoundation_hub_network_deploy_user"` | no |
| <a name="input_hub_resource_group"></a> [hub\_resource\_group](#input\_hub\_resource\_group) | Name of the hub resource group | `string` | `"hub-vnet-rg"` | no |
| <a name="input_hub_vnet_name"></a> [hub\_vnet\_name](#input\_hub\_vnet\_name) | Name of the hub virtual network | `string` | `"hub-vnet"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location/region for deploying resources | `string` | n/a | yes |
| <a name="input_lz_networking_deploy"></a> [lz\_networking\_deploy](#input\_lz\_networking\_deploy) | Service Principal responsible for deploying the landing zone networking | `string` | `"cloudfoundation_lz_network_deploy_user"` | no |
| <a name="input_management_nsg_rules"></a> [management\_nsg\_rules](#input\_management\_nsg\_rules) | Network security rules to add to management subnet. See README for details on how to setup. | `list(any)` | `[]` | no |
| <a name="input_mgmt_ip_names"></a> [mgmt\_ip\_names](#input\_mgmt\_ip\_names) | Public ips is a list of ip names that are connected to the firewall. At least one is required. | `list(string)` | <pre>[<br>  "fw-mgmt"<br>]</pre> | no |
| <a name="input_netwatcher"></a> [netwatcher](#input\_netwatcher) | Properties for creating network watcher. If set it will create Network Watcher resource using standard naming standard. | <pre>object({<br>    #resource_group_location    = string<br>    log_analytics_workspace_id       = string<br>    log_analytics_workspace_id_short = string<br>    log_analytics_resource_id        = string<br>  })</pre> | `null` | no |
| <a name="input_network_admin_group"></a> [network\_admin\_group](#input\_network\_admin\_group) | Name of the Cloud Foundation network admin group | `string` | `"cloudfoundation-network-admins"` | no |
| <a name="input_parent_management_group_id"></a> [parent\_management\_group\_id](#input\_parent\_management\_group\_id) | ID of the parent management group | `string` | n/a | yes |
| <a name="input_public_ip_names"></a> [public\_ip\_names](#input\_public\_ip\_names) | Public ips is a list of ip names that are connected to the firewall. At least one is required. | `list(string)` | <pre>[<br>  "fw-public"<br>]</pre> | no |
| <a name="input_public_ip_prefix_length"></a> [public\_ip\_prefix\_length](#input\_public\_ip\_prefix\_length) | Specifies the number of bits of the prefix. The value can be set between 24 (256 addresses) and 31 (2 addresses). | `number` | `30` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | ID of the management group that you want to manage spokes in | `string` | n/a | yes |
| <a name="input_scope_network_admin"></a> [scope\_network\_admin](#input\_scope\_network\_admin) | ID of the management group that you want to manage spokes in | `string` | n/a | yes |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | Service endpoints to add to the firewall subnet. | `list(string)` | <pre>[<br>  "Microsoft.AzureActiveDirectory",<br>  "Microsoft.AzureCosmosDB",<br>  "Microsoft.EventHub",<br>  "Microsoft.KeyVault",<br>  "Microsoft.ServiceBus",<br>  "Microsoft.Sql",<br>  "Microsoft.Storage"<br>]</pre> | no |
| <a name="input_threat_intel_mode"></a> [threat\_intel\_mode](#input\_threat\_intel\_mode) | The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert, Deny and ""(empty string). | `string` | `"Off"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_hub_location"></a> [hub\_location](#output\_hub\_location) | Location of hub vnet |
| <a name="output_hub_rg"></a> [hub\_rg](#output\_hub\_rg) | Resource Group of hub vnet |
| <a name="output_hub_subscription"></a> [hub\_subscription](#output\_hub\_subscription) | Subscription of hub vnet |
| <a name="output_hub_vnet"></a> [hub\_vnet](#output\_hub\_vnet) | Name of hub vnet |
<!-- END_TF_DOCS -->

