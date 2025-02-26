# Terraform OVH platform users

This Terraform module sets up and manages OVH platform users and integrates with AWS for backend state management.

## Prerequisites

- Terraform v1.0.0 or higher
- AWS account with appropriate permissions
- OVH account with appropriate permissions

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "ovh_users" {
  source = "./buildingblock"

  aws_account_id = "your-aws-account-id"
  users = [
    {
      meshIdentifier = "identifier0"
      username       = "user0@example.com"
      firstName      = "First"
      lastName       = "Last"
      email          = "user0@example.com"
      euid           = "user0@example.com"
      roles          = ["reader"]
    }
 ]
}
```

## Providers

The module requires the following providers, as specified in versions.tf:

- `ovh`: Manages OVH resources.
- `aws`: Manages AWS resources.
- `random`: Generates random values.

## Backend Configuration

The module uses AWS S3 as the backend for storing Terraform state. This is configured in versions.tf:

```hcl
terraform {
  backend "s3" {
    bucket = "yourbucket"
    key    = "terraform/ovh-project-users"
    region = "eu-central-1"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.65.0 |
| <a name="requirement_ovh"></a> [ovh](#requirement\_ovh) | 1.5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ovh_me_identity_user.platform_users](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/resources/me_identity_user) | resource |
| [random_password.user_passwords](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/password) | resource |
| [ovh_me.myaccount](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/data-sources/me) | data source |
| [ovh_me_identity_users.users](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/data-sources/me_identity_users) | data source |
| [ovh_order_cart.mycart](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/data-sources/order_cart) | data source |
| [ovh_order_cart_product_plan.cloud](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/data-sources/order_cart_product_plan) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | this is for the tfstates Backend. in our case AWS. | `string` | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | Users and their roles provided by meshStack (Note that users must exist in stackit) | <pre>list(object(<br>    {<br>      meshIdentifier = string<br>      username       = string<br>      firstName      = string<br>      lastName       = string<br>      email          = string<br>      euid           = string<br>      roles          = list(string)<br>    }<br>  ))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
