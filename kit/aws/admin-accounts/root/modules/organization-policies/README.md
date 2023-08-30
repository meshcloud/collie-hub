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
| [aws_organizations_policy.deny_outside_eu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_whitelisted_global_services"></a> [whitelisted\_global\_services](#input\_whitelisted\_global\_services) | List of AWS services that need global region access to work as intended | `list(string)` | <pre>[<br>  "cloudfront",<br>  "iam",<br>  "route53",<br>  "support"<br>]</pre> | no |
| <a name="input_whitelisted_regions"></a> [whitelisted\_regions](#input\_whitelisted\_regions) | List of AWS regions to allow | `list(string)` | <pre>[<br>  "eu-central-1",<br>  "eu-west-1"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documentation"></a> [documentation](#output\_documentation) | n/a |
<!-- END_TF_DOCS -->