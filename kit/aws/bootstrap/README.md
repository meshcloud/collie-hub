---
name: AWS Platform Bootstrap
summary: |
  creates a service user with permissions to deploy the cloud foundation infrastructure.
  This is a "bootstrap" module, which means that it must be manually executed once by an administrator
  to bootstrap the cloudfoundation
compliance:
  - control: cfmm/iam/privileged-access-management
    statement: |
      The deploy user has privileged access to the cloud foundation infrastructure.
      Access to the credentials of this user are carefully controlled via...
---

# AWS Platform Bootstrap

Creates a service user with permissions to deploy the cloud foundation infrastructure.
This is a "bootstrap" module, which means that it must be manually executed once by an administrator
to bootstrap the cloudfoundation.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.14.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.user-policy-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_root_account_id"></a> [aws\_root\_account\_id](#input\_aws\_root\_account\_id) | The id of your AWS Organization's root account | `string` | n/a | yes |
| <a name="input_iam_user_name"></a> [iam\_user\_name](#input\_iam\_user\_name) | name of the AWS IAM user | `string` | `"cloudfoundation_tf_deploy_user"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_root_account_id"></a> [aws\_root\_account\_id](#output\_aws\_root\_account\_id) | The id of your AWS Organization's root account |
| <a name="output_cloudfoundation_tf_deploy_user_iam_access_key_id"></a> [cloudfoundation\_tf\_deploy\_user\_iam\_access\_key\_id](#output\_cloudfoundation\_tf\_deploy\_user\_iam\_access\_key\_id) | n/a |
| <a name="output_cloudfoundation_tf_deploy_user_iam_access_key_secret"></a> [cloudfoundation\_tf\_deploy\_user\_iam\_access\_key\_secret](#output\_cloudfoundation\_tf\_deploy\_user\_iam\_access\_key\_secret) | n/a |
| <a name="output_documentation_md"></a> [documentation\_md](#output\_documentation\_md) | n/a |
<!-- END_TF_DOCS -->