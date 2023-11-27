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
| [azuread_group_member.pam_desired_memberships](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azuread_group.pam_desired_groups](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.pam_groups](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_user.pam_desired_users](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azuread_user.pam_users](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pam_group_members"></a> [pam\_group\_members](#input\_pam\_group\_members) | Optional: manage members for cloud foundation PAM groups via terraform | <pre>list(object({<br>    group_object_id = string<br>    <br>    # other attributes would be possible (e.g. UPN or mail_nickname) with small changes to the terraform module<br>    members_by_mail = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_pam_group_object_ids"></a> [pam\_group\_object\_ids](#input\_pam\_group\_object\_ids) | the object\_ids of PAM groups used by the cloud foundation | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->
