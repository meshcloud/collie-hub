---
name: Azure Network
summary: |
  compliance:
  - control: cfmm/service-ecosystem/virtual-network-service
  statement: |
    A virtual network allows resources to communicate with other resources. The other resources may be within the same virtual network,
    but could also be on-premise or on the internet.

---

# Azure Network

The Azure Network Kit defines the networking components within the Azure cloud environment. This infrastructure is
designed to facilitate communication between various resources, whether they are within the same virtual network, on-premise, or
on the internet.

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
| [azurerm_firewall_application_rule_collection.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_application_rule_collection) | resource |
| [azurerm_firewall_nat_rule_collection.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_nat_rule_collection) | resource |
| [azurerm_firewall_network_rule_collection.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_network_rule_collection) | resource |
| [azurerm_management_group_subscription_association.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association) | resource |
| [azurerm_monitor_diagnostic_setting.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
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
| [azurerm_route.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
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
| [azurerm_monitor_diagnostic_categories.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.fw_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | List of address spaces for virtual networks | `string` | n/a | yes |
| <a name="input_cloudfoundation"></a> [cloudfoundation](#input\_cloudfoundation) | Name of your cloud foundation | `string` | n/a | yes |
| <a name="input_cloudfoundation_deploy_principal_id"></a> [cloudfoundation\_deploy\_principal\_id](#input\_cloudfoundation\_deploy\_principal\_id) | Principal ID authorized for deploying Cloud Foundation resources | `string` | n/a | yes |
| <a name="input_connectivity_scope"></a> [connectivity\_scope](#input\_connectivity\_scope) | Identifier for the management group connectivity | `string` | n/a | yes |
| <a name="input_create_ddos_plan"></a> [create\_ddos\_plan](#input\_create\_ddos\_plan) | Create a DDos protection plan and attach it to the virtual network. | `bool` | `false` | no |
| <a name="input_deploy_firewall"></a> [deploy\_firewall](#input\_deploy\_firewall) | Toggle to deploy or bypass the firewall. | `bool` | `false` | no |
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | Diagnostic settings for supporting resources. Refer to README.md for configuration details. | <pre>object({<br>    destination = string<br>    logs        = list(string)<br>    metrics     = list(string)<br>  })</pre> | `null` | no |
| <a name="input_firewall_application_rules"></a> [firewall\_application\_rules](#input\_firewall\_application\_rules) | List of application rules to apply to the firewall. | <pre>list(object({<br>    name             = string<br>    action           = string<br>    source_addresses = list(string)<br>    target_fqdns     = list(string)<br>    protocol = object({<br>      type = string<br>      port = string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_firewall_nat_rules"></a> [firewall\_nat\_rules](#input\_firewall\_nat\_rules) | List of NAT rules to apply to the firewall. | <pre>list(object({<br>    name                  = string<br>    action                = string<br>    source_addresses      = list(string)<br>    destination_ports     = list(string)<br>    destination_addresses = list(string)<br>    protocols             = list(string)<br>    translated_address    = string<br>    translated_port       = string<br>  }))</pre> | `[]` | no |
| <a name="input_firewall_network_rules"></a> [firewall\_network\_rules](#input\_firewall\_network\_rules) | List of network rules to apply to the firewall. | <pre>list(object({<br>    name                  = string<br>    action                = string<br>    source_addresses      = list(string)<br>    destination_ports     = list(string)<br>    destination_addresses = list(string)<br>    protocols             = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_firewall_sku_tier"></a> [firewall\_sku\_tier](#input\_firewall\_sku\_tier) | Specify the tier for the firewall, choosing from options like Basic or Standard, Premium. | `string` | `"Basic"` | no |
| <a name="input_firewall_zones"></a> [firewall\_zones](#input\_firewall\_zones) | Collection of availability zones to distribute the Firewall across. | `list(string)` | `null` | no |
| <a name="input_hub_networking_deploy"></a> [hub\_networking\_deploy](#input\_hub\_networking\_deploy) | Service Principal responsible for deploying the central hub networking | `string` | `"cloudfoundation_hub_network_deploy_user"` | no |
| <a name="input_hub_resource_group"></a> [hub\_resource\_group](#input\_hub\_resource\_group) | Name of the central hub resource group | `string` | `"hub-vnet-rg"` | no |
| <a name="input_hub_subscription_name"></a> [hub\_subscription\_name](#input\_hub\_subscription\_name) | Name of your hub subscription | `string` | `"hub"` | no |
| <a name="input_hub_vnet_name"></a> [hub\_vnet\_name](#input\_hub\_vnet\_name) | Name of the central virtual network | `string` | `"hub-vnet"` | no |
| <a name="input_landingzone_scope"></a> [landingzone\_scope](#input\_landingzone\_scope) | Identifier for the management group landinzone | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Region for resource deployment | `string` | n/a | yes |
| <a name="input_lz_networking_deploy"></a> [lz\_networking\_deploy](#input\_lz\_networking\_deploy) | Service Principal responsible for deploying the landing zone networking | `string` | `"cloudfoundation_lz_network_deploy_user"` | no |
| <a name="input_management_nsg_rules"></a> [management\_nsg\_rules](#input\_management\_nsg\_rules) | Network security rules to add to the management subnet. Refer to README for setup details. | `list(any)` | `[]` | no |
| <a name="input_netwatcher"></a> [netwatcher](#input\_netwatcher) | Properties for creating network watcher. If set, it creates a Network Watcher resource using standard naming conventions. | <pre>object({<br>    log_analytics_workspace_id       = string<br>    log_analytics_workspace_id_short = string<br>    log_analytics_resource_id        = string<br>  })</pre> | `null` | no |
| <a name="input_network_admin_group"></a> [network\_admin\_group](#input\_network\_admin\_group) | Name of the Cloud Foundation network administration group | `string` | `"cloudfoundation-network-admins"` | no |
| <a name="input_public_ip_names"></a> [public\_ip\_names](#input\_public\_ip\_names) | List of public IP names connected to the firewall. At least one is required. | `list(string)` | <pre>[<br>  "fw-public"<br>]</pre> | no |
| <a name="input_public_ip_prefix_length"></a> [public\_ip\_prefix\_length](#input\_public\_ip\_prefix\_length) | Specifies the number of bits in the prefix. Value can be set between 24 (256 addresses) and 31 (2 addresses). | `number` | `30` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | Service endpoints to add to the firewall subnet. | `list(string)` | <pre>[<br>  "Microsoft.AzureActiveDirectory",<br>  "Microsoft.AzureCosmosDB",<br>  "Microsoft.EventHub",<br>  "Microsoft.KeyVault",<br>  "Microsoft.ServiceBus",<br>  "Microsoft.Sql",<br>  "Microsoft.Storage"<br>]</pre> | no |
| <a name="input_threat_intel_mode"></a> [threat\_intel\_mode](#input\_threat\_intel\_mode) | Operation mode for threat intelligence-based filtering. Possible values: Off, Alert, Deny, and "" (empty string). | `string` | `"Off"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_firewall_name"></a> [firewall\_name](#output\_firewall\_name) | Name of hub vnet |
| <a name="output_hub_location"></a> [hub\_location](#output\_hub\_location) | Location of hub vnet |
| <a name="output_hub_rg"></a> [hub\_rg](#output\_hub\_rg) | Resource Group of hub vnet |
| <a name="output_hub_subscription"></a> [hub\_subscription](#output\_hub\_subscription) | Subscription of hub vnet |
| <a name="output_hub_vnet"></a> [hub\_vnet](#output\_hub\_vnet) | Name of hub vnet |
| <a name="output_network_admins_azuread_group_id"></a> [network\_admins\_azuread\_group\_id](#output\_network\_admins\_azuread\_group\_id) | n/a |
<!-- END_TF_DOCS -->

