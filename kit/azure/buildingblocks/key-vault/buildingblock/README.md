# Terraform Module: Azure Key Vault

This Terraform module provisions an Azure Key Vault along with necessary role assignments.

## Features
- Creates an Azure Key Vault with soft delete and purge protection enabled.
- Assigns the "Key Vault Administrator" role to a specified Azure AD group.
- Outputs essential details like Key Vault ID, name, and resource group.

## Requirements
- Terraform `>= 1.0`
- AzureRM Provider `>= 4.18.0`

## Providers

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.18.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

## Inputs

| Name                          | Type   | Description                                      | Required |
|--------------------------------|--------|--------------------------------------------------|----------|
| `key_vault_name`              | string | The name of the Key Vault.                      | Yes      |
| `key_vault_resource_group_name` | string | The name of the resource group for the Key Vault. | Yes      |
| `location`                    | string | The Azure region where the Key Vault is created. | Yes      |

## Outputs

| Name                        | Description                                    |
|-----------------------------|------------------------------------------------|
| `key_vault_id`             | The ID of the created Key Vault.              |
| `key_vault_name`           | The name of the created Key Vault.            |
| `key_vault_resource_group` | The resource group containing the Key Vault.  |

## Usage Example

```hcl
module "key_vault" {
  source                        = "./modules/key_vault"
  key_vault_name                = "my-keyvault"
  key_vault_resource_group_name = "my-resource-group"
  location                      = "West Europe"
}

output "vault_id" {
  value = module.key_vault.key_vault_id
}
```

## Notes
- Make sure the Azure AD group exists before assigning the role.
- Ensure that your Terraform identity has the necessary permissions to create and manage Key Vaults.

## License
MIT


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.18.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/4.18.0/docs/resources/key_vault) | resource |
| [azurerm_resource_group.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/4.18.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.cloudfoundation_tfdeploy](https://registry.terraform.io/providers/hashicorp/azurerm/4.18.0/docs/resources/role_assignment) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/string) | resource |
| [azuread_user.users](https://registry.terraform.io/providers/hashicorp/azuread/3.1.0/docs/data-sources/user) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.18.0/docs/data-sources/client_config) | data source |
| [azurerm_role_definition.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/4.18.0/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.18.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | The name of the key vault. | `string` | n/a | yes |
| <a name="input_key_vault_resource_group_name"></a> [key\_vault\_resource\_group\_name](#input\_key\_vault\_resource\_group\_name) | The name of the resource group containing the key vault. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the key vault is created. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | Users and their roles provided by meshStack (Note that users must exist in stackit) | <pre>list(object(<br>    {<br>      meshIdentifier = string<br>      username       = string<br>      firstName      = string<br>      lastName       = string<br>      email          = string<br>      euid           = string<br>      roles          = list(string)<br>    }<br>  ))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | n/a |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | n/a |
| <a name="output_key_vault_resource_group"></a> [key\_vault\_resource\_group](#output\_key\_vault\_resource\_group) | n/a |
<!-- END_TF_DOCS -->