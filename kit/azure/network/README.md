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