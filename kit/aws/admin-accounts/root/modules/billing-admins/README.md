<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssoadmin_account_assignment.billing_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_ssoadmin_managed_policy_attachment.billing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_managed_policy_attachment) | resource |
| [aws_ssoadmin_permission_set.billing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | n/a | yes |
| <a name="input_aws_root_account_id"></a> [aws\_root\_account\_id](#input\_aws\_root\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_aws_sso_instance_arn"></a> [aws\_sso\_instance\_arn](#input\_aws\_sso\_instance\_arn) | best retrieved via tolist(data.aws\_ssoadmin\_instances.$xxx.arns)[0] | `string` | n/a | yes |
| <a name="input_billing_users"></a> [billing\_users](#input\_billing\_users) | The list of user principals that shall be granted billing access | <pre>list(object({<br>    principal_id = string, # Note: currently its not possible to look up users by username with AWS SSO via terraform, we have to hardcode the ids.<br>    email        = string,<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation"></a> [documentation](#output\_documentation) | n/a |
<!-- END_TF_DOCS -->