---
name: Privileged Access Management
summary: |
  Privileged Access Management (PAM) refers to the implementation of security measures and best practices to control and monitor access to critical resources within cloud platforms. For cloud foundation teams, it is about safeguarding administrative roles that enable access to core infrastructure, ensuring the security, compliance, and visibility needed to oversee application teams' cloud usage.
# optional: add additional metadata about implemented security controls
---

# Privileged Access Management

This kit provides a Terraform configuration for setting up PAM in Azure.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_group_member.billing_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group_member.billing_readers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group_member.security_auditors](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azuread_users.billing_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |
| [azuread_users.billing_readers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |
| [azuread_users.security_auditors](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |
| [azurerm_management_group.root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_admin_group"></a> [billing\_admin\_group](#input\_billing\_admin\_group) | object\_id of the billing admin group | `string` | n/a | yes |
| <a name="input_billing_admin_members"></a> [billing\_admin\_members](#input\_billing\_admin\_members) | Set up a group of platform engineers. If enabled, this group will receive access to terraform\_state\_storage | <pre>list(object({<br>    email = string,<br>    upn   = string,<br>  }))</pre> | n/a | yes |
| <a name="input_billing_reader_group"></a> [billing\_reader\_group](#input\_billing\_reader\_group) | object\_id of the billing reader group | `string` | n/a | yes |
| <a name="input_billing_reader_members"></a> [billing\_reader\_members](#input\_billing\_reader\_members) | Set up a group of platform engineers. If enabled, this group will receive access to terraform\_state\_storage | <pre>list(object({<br>    email = string,<br>    upn   = string,<br>  }))</pre> | n/a | yes |
| <a name="input_security_auditor_group"></a> [security\_auditor\_group](#input\_security\_auditor\_group) | object\_id of the security auditor group | `string` | n/a | yes |
| <a name="input_security_auditor_members"></a> [security\_auditor\_members](#input\_security\_auditor\_members) | Set up a group of platform engineers. If enabled, this group will receive access to terraform\_state\_storage | <pre>list(object({<br>    email = string,<br>    upn   = string,<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
