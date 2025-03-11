# Terraform Azure PostgreSQL Database Module

This Terraform module creates a PostgreSQL database in Azure with a configurable setup.

## ⚙️ Features
- **Customizable Database Configuration**:
  - Character set and collation can be specified
  - Prevents accidental deletion with `prevent_destroy`
- **Modular and Reusable**:
  - Defined via `variables.tf`
  - Outputs database details for further use

## 🚀 Deployment

### Prerequisites
- Terraform (≥ 1.3.0)
- Azure CLI authenticated (`az login`)

### Steps
1. **Initialize Terraform**:
    ```bash
    terraform init
    ```
2. **Preview the deployment**:
    ```bash
    terraform plan
    ```
3. **Apply the configuration**:
    ```bash
    terraform apply -auto-approve
    ```
4. **Retrieve PostgreSQL database details**:
    ```bash
    terraform output
    ```

## 📚 Notes
- **Character Set**: Defaults to `UTF8`, configurable via `charset` variable.
- **Collation**: Defaults to `English_United States.1252`, configurable via `collation` variable.
- **Deletion Protection**: `prevent_destroy` is enabled to avoid accidental data loss.

## 🛠 Configuration

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.22.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_database.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/postgresql_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_charset"></a> [charset](#input\_charset) | Character set for the database | `string` | `"UTF8"` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | Collation for the database | `string` | `"English_United States.1252"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the PostgreSQL database | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the database will be created | `string` | n/a | yes |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | The name of the PostgreSQL server | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | the Azure subscription id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_id"></a> [database\_id](#output\_database\_id) | The ID of the created PostgreSQL database |
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | The name of the created PostgreSQL database |
<!-- END_TF_DOCS -->