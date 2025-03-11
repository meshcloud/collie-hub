# Terraform Azure PostgreSQL Deployment

This Terraform project deploys a cost-effective Azure PostgreSQL database with minimal resources and security-conscious configuration.

## ⚙️ Features
- **Cheapest SKU**: B_Standard_B1ms (1 vCore, 2 GB RAM)
- **Minimal Storage**: 5 GB
- **Security-Optimized**:
  - Public network access disabled
  - Enforced SSL/TLS encryption (TLS1_2)
  - Auto-grow disabled to prevent unexpected costs
  - Automated Admin Password Generation with the random provider
- **Modular and Configurable** via `variables.tf`

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
4. **Retrieve PostgreSQL details**:
    ```bash
    terraform output
    ```

## 📚 Notes
- **Backup Retention**: Minimum is 7 days (Azure limitation).
- **Geo-Redundant Backup**: Disabled to minimize costs.
- For **production**:
  - Consider enabling auto-grow.
  - Use Key Vault for secrets.
  - Restrict IPs via firewall rules.

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
| [azurerm_postgresql_server.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/postgresql_server) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/resource_group) | resource |
| [random_password.psql_admin_password](https://registry.terraform.io/providers/hashicorp/random/3.7.1/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | Administrator username for PostgreSQL | `string` | `"psqladmin"` | no |
| <a name="input_auto_grow_enabled"></a> [auto\_grow\_enabled](#input\_auto\_grow\_enabled) | Enable auto-grow for storage | `bool` | `false` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | Backup retention in days | `number` | `7` | no |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Enable geo-redundant backups | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region | `string` | `"West Europe"` | no |
| <a name="input_postgresql_server_name"></a> [postgresql\_server\_name](#input\_postgresql\_server\_name) | Name of the PostgreSQL server | `string` | n/a | yes |
| <a name="input_postgresql_version"></a> [postgresql\_version](#input\_postgresql\_version) | PostgreSQL version | `string` | `"11"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable public network access | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Azure resource group | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for the PostgreSQL server | `string` | `"B_Standard_B1ms"` | no |
| <a name="input_ssl_enforcement_enabled"></a> [ssl\_enforcement\_enabled](#input\_ssl\_enforcement\_enabled) | Enforce SSL connection | `bool` | `true` | no |
| <a name="input_ssl_minimal_tls_version_enforced"></a> [ssl\_minimal\_tls\_version\_enforced](#input\_ssl\_minimal\_tls\_version\_enforced) | Minimum TLS version | `string` | `"TLS1_2"` | no |
| <a name="input_storage_mb"></a> [storage\_mb](#input\_storage\_mb) | Storage size in MB | `number` | `5120` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_postgresql_admin_username"></a> [postgresql\_admin\_username](#output\_postgresql\_admin\_username) | The administrator username for PostgreSQL |
| <a name="output_postgresql_fqdn"></a> [postgresql\_fqdn](#output\_postgresql\_fqdn) | The fully qualified domain name of the PostgreSQL server |
| <a name="output_postgresql_server_name"></a> [postgresql\_server\_name](#output\_postgresql\_server\_name) | The name of the PostgreSQL server |
| <a name="output_postgresql_storage_mb"></a> [postgresql\_storage\_mb](#output\_postgresql\_storage\_mb) | The allocated storage in MB |
| <a name="output_postgresql_version"></a> [postgresql\_version](#output\_postgresql\_version) | The PostgreSQL version |
| <a name="output_psql_admin_password"></a> [psql\_admin\_password](#output\_psql\_admin\_password) | The administrator password for PostgreSQL |
<!-- END_TF_DOCS -->