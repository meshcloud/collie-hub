---
name: Root Account
summary: |
  configures the AWS root account that hosts the AWS Organization.
  This module applies all non-bootstrap settings to the root account.
compliance:
- control: compliance/cfmm/iam/privileged-access-management
  statement: |
    The list of billing-admins is hardcoded.
    Adding permission requires pull-request review for changes made to the IaC code.
- control: compliance/cfmm/iam/authorization-concept
  statement: |
    Billing admins can see all charges and manage payment methods for the entire AWS organisation.
    They can also make changes to the organization's payment method. The billing admin is thus considered a privileged role.
- control: compliance/cfmm/security-and-compliance/resource-policies-blacklisting
  statement: |
    A service control policy denies access to any non-EU AWS regions.
---

# Root Account

The root account hosts the AWS Organization. It should not be used for hosting any workload.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_billing_admins"></a> [billing\_admins](#module\_billing\_admins) | .//modules/billing-admins/ | n/a |
| <a name="module_organization_policies"></a> [organization\_policies](#module\_organization\_policies) | .//modules/organization-policies | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.output_md](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [aws_ssoadmin_instances.sso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | n/a | yes |
| <a name="input_aws_root_account_id"></a> [aws\_root\_account\_id](#input\_aws\_root\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_billing_users"></a> [billing\_users](#input\_billing\_users) | The list of user principals that shall be granted billing access | <pre>list(object({<br>    principal_id = string,<br>    email        = string,<br>  }))</pre> | `[]` | no |
| <a name="input_output_md_file"></a> [output\_md\_file](#input\_output\_md\_file) | location of the file where this cloud foundation kit module generates its documentation output | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->