# OVH Cloud Custom Platform

## Overview

This project provides a Terraform configuration for provisioning and managing OVH Cloud resources. It includes the creation of platform users with randomly generated passwords and the necessary outputs for further use.

## Documentation

For more information, check our [Guide for OVH](https://likvid-cloudfoundation/meshstack/guides/guide_ovh.html).

## Providers

- `ovh`: Version 1.5.0
- `random`: Version 3.6.0
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ovh"></a> [ovh](#requirement\_ovh) | 1.5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ovh_me_identity_user.platform_users](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/resources/me_identity_user) | resource |
| [random_password.user_passwords](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_platform_admins"></a> [platform\_admins](#input\_platform\_admins) | n/a | <pre>list(object({<br>    email = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
| <a name="output_platform_users"></a> [platform\_users](#output\_platform\_users) | n/a |
| <a name="output_user_passwords"></a> [user\_passwords](#output\_user\_passwords) | n/a |
<!-- END_TF_DOCS -->
