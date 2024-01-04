# hub-vnet
    This Building Block creates an unmanaged hub vnet in a new resource group.

![azure-vnet](icon.png)

## overview
    Following resources will be created using this module:
    - Resource group
    - Virtual network
    - Azure firewall
    - VPN Gateway
    - A linux VM as bastion host
    - Route table
    - NSG and subnet

    After deploying this building block, you will have an unmanaged Hub virtual network with an Azure firewall, Bastion host, and a Gateway inside of it. The access to the VM is possible via SSH to the Public IP of the Firewall using port "2222".
## How to use this Building Block in meshStack

1. Go to your meshStack admin area and click on "Building Blocks" from the left pane
2. Click on "Create Building Block"
3. Fill out the general information and click next
4. Select "Azure" as your supported platform
5. Select "Terraform" in Implementation Type and put in the Terraform version
6. Copy the repository HTTPS address to the "Git Repository URL" field (if its a private repo, add your SSH key) click next
7. For the input do the following
    - add the service principal's "ARM_CLIENT_SECRET" and "ARM_CLIENT_ID" as Environmental Variable
    - add the add the "subscription_id" as "Platform Tenant ID"
    - add the rest of the variables as platform operator or user input
8. On the next page, add the outputs from outputs.tf file and click on Create Building Block
9. Now users can add this building block to their tenants

## Backend configuration
Here you can find an example of how to create a backend.tf file on this [Wiki Page](https://github.com/meshcloud/building-blocks/wiki/%5BUser-Guide%5D-Setting-up-the-Backend-for-terraform-state#how-to-configure-backendtf-file-for-these-providers)
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | > 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.bastion_NSG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_resource_group.hub-vnet-rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.azurefirewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.hub-bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.hub-gateway-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.bastion_NSG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.hub-vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The password of the administrator of the linux VM. | `string` | n/a | yes |
| <a name="input_hub-route-table"></a> [hub-route-table](#input\_hub-route-table) | Name of the route table in the hub network | `string` | `"hub-route-table"` | no |
| <a name="input_hub-vnet"></a> [hub-vnet](#input\_hub-vnet) | The name of the hub virtual network | `string` | `"hub-vnet"` | no |
| <a name="input_hub-vnet-rg"></a> [hub-vnet-rg](#input\_hub-vnet-rg) | The resource group name holding the hub vnet | `string` | `"hub-rg"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the network | `string` | `"germanywestcentral"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->