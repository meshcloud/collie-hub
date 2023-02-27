---
name: Standard VM windows
summary: |
  deploys new cloud foundation infrastructure.
  Add a concise description of the module's purpose here.
# optional: add additional metadata about implemented security controls
---

# Standard VM windows

This documentation is intended as a reference documentation for cloud foundation or platform engineers using this module.
    
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dev_test_global_vm_shutdown_schedule.win_vm_shutdown_schedule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dev_test_global_vm_shutdown_schedule) | resource |
| [azurerm_key_vault.win_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.keyvault_user_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.spn_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.winvmpassword](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_network_interface.win_vm_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.vm_subnet_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.vm_nsg_rule_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.win_vm_publicip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.vm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.vm_subnet_nsg_associate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_windows_virtual_machine.win_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [local_file.output_md](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_password.winvmpassword](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.myrandom](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aadTenantId"></a> [aadTenantId](#input\_aadTenantId) | n/a | `string` | n/a | yes |
| <a name="input_keyvault_user_object_id"></a> [keyvault\_user\_object\_id](#input\_keyvault\_user\_object\_id) | n/a | `map` | n/a | yes |
| <a name="input_output_md_file"></a> [output\_md\_file](#input\_output\_md\_file) | location of the file where this cloud foundation kit module generates its documentation output | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Region in which Azure Resources to be created | `string` | `"West Europe"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group Name | `string` | `"rg-default"` | no |
| <a name="input_vm_subnet_address"></a> [vm\_subnet\_address](#input\_vm\_subnet\_address) | Virtual Network VM Subnet Address Spaces | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_vm_subnet_name"></a> [vm\_subnet\_name](#input\_vm\_subnet\_name) | Virtual Network VM Subnet Name | `string` | `"websubnet"` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | Virtual Network address\_space | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Virtual Network name | `string` | `"vnet-default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | Virtual Network ID |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | Virtual Network Name |
| <a name="output_vm_subnet_id"></a> [vm\_subnet\_id](#output\_vm\_subnet\_id) | vm Subnet ID |
| <a name="output_vm_subnet_name"></a> [vm\_subnet\_name](#output\_vm\_subnet\_name) | vmTier Subnet Name |
| <a name="output_vm_subnet_nsg_id"></a> [vm\_subnet\_nsg\_id](#output\_vm\_subnet\_nsg\_id) | vm Subnet NSG ID |
| <a name="output_vm_subnet_nsg_name"></a> [vm\_subnet\_nsg\_name](#output\_vm\_subnet\_nsg\_name) | vm Subnet NSG Name |
| <a name="output_web_linuxvm_network_interface_private_ip_addresses"></a> [web\_linuxvm\_network\_interface\_private\_ip\_addresses](#output\_web\_linuxvm\_network\_interface\_private\_ip\_addresses) | Windows VM Private IP Addresses |
| <a name="output_win_vm_network_interface_id"></a> [win\_vm\_network\_interface\_id](#output\_win\_vm\_network\_interface\_id) | Windows VM Network Interface ID |
| <a name="output_win_vm_private_ip_address"></a> [win\_vm\_private\_ip\_address](#output\_win\_vm\_private\_ip\_address) | Windows Virtual Machine Private IP |
| <a name="output_win_vm_public_ip"></a> [win\_vm\_public\_ip](#output\_win\_vm\_public\_ip) | Windows VM Public Address |
| <a name="output_win_vm_public_ip_address"></a> [win\_vm\_public\_ip\_address](#output\_win\_vm\_public\_ip\_address) | Windows Virtual Machine Public IP |
| <a name="output_win_vm_virtual_machine_id"></a> [win\_vm\_virtual\_machine\_id](#output\_win\_vm\_virtual\_machine\_id) | Windows Virtual Machine ID |
<!-- END_TF_DOCS -->