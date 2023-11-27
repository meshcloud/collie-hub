---
name: Azure Privileged Access Management
summary: |
  Privileged Access Management (PAM) refers to the implementation of security measures and best practices to control and monitor access to critical resources within cloud platforms. For cloud foundation teams, it is about safeguarding administrative roles that enable access to core infrastructure, ensuring the security, compliance, and visibility needed to oversee application teams' cloud usage.
compliance:
  - control: cfmm/iam/privileged-access-management
    statement: |
       Implements PAM for security auditors, billing readers, network admins.
---

# Privileged Access Management

This kit provides a basic terraform-based approach for managing privileged roles used to administrate your landing zones.

This is a good solution for cloud foundation teams that start in greenfield Azure environments and without a strong 
backing of established enterprise IAM integration into Entra ID (Azure AD). 

> For production use, cloud foundation teams should strongly consider implementing group membership management using
> existing Enterprise IAM processes as well as leveraging Entra ID PIM and Conditional Access features to increase
> security.

This module is meant to be used with modules like `azure/billing` or `azure/logging` that implement important
administrative capabilities and also introduce relevant security groups for manging these capabilities.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.41.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.71.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_group_member.billing_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group_member.billing_readers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group_member.security_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group_member.security_auditors](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azuread_users.billing_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |
| [azuread_users.billing_readers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |
| [azuread_users.security_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |
| [azuread_users.security_auditors](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |
| [azurerm_management_group.root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_admin"></a> [billing\_admin](#input\_billing\_admin) | this variable fetchs the output values of the billing kit | <pre>object({<br>    group = object({ object_id = string, display_name = string })<br>  })</pre> | n/a | yes |
| <a name="input_billing_admin_members"></a> [billing\_admin\_members](#input\_billing\_admin\_members) | Admins for Cost Management | <pre>list(object({<br>    email = string,<br>    upn   = string,<br>  }))</pre> | n/a | yes |
| <a name="input_billing_reader"></a> [billing\_reader](#input\_billing\_reader) | this variable fetchs the output values of the billing kit | <pre>object({<br>    group = object({ object_id = string, display_name = string })<br>  })</pre> | n/a | yes |
| <a name="input_billing_reader_members"></a> [billing\_reader\_members](#input\_billing\_reader\_members) | Auditors for Cost Management | <pre>list(object({<br>    email = string,<br>    upn   = string,<br>  }))</pre> | n/a | yes |
| <a name="input_platform_engineer"></a> [platform\_engineer](#input\_platform\_engineer) | this variable fetchs the output values of the billing kit | <pre>object({<br>    group = object({ object_id = string, display_name = string, member = list(string) })<br>  })</pre> | n/a | yes |
| <a name="input_security_admin"></a> [security\_admin](#input\_security\_admin) | this variable fetchs the output values of the logging kit | <pre>object({<br>    group = object({ object_id = string, display_name = string })<br>  })</pre> | n/a | yes |
| <a name="input_security_admin_members"></a> [security\_admin\_members](#input\_security\_admin\_members) | Security Admins for the Log Analytics Workspace | <pre>list(object({<br>    email = string,<br>    upn   = string,<br>  }))</pre> | n/a | yes |
| <a name="input_security_auditor"></a> [security\_auditor](#input\_security\_auditor) | this variable fetchs the output values of the logging kit | <pre>object({<br>    group = object({ object_id = string, display_name = string })<br>  })</pre> | n/a | yes |
| <a name="input_security_auditor_members"></a> [security\_auditor\_members](#input\_security\_auditor\_members) | Security Auditors for the Log Analytics Workspace | <pre>list(object({<br>    email = string,<br>    upn   = string,<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->
