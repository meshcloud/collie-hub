# Terraform OVH Project

This Terraform project sets up an OVH cloud project with IAM policies for different user roles. It also configures AWS as the backend for Terraform state.

## Prerequisites

- Terraform installed on your machine.
- AWS and OVH credentials configured.

## Usage

1. Clone the repository.
2. Initialize Terraform:
   ```sh
   terraform init
   ```
3. Apply the Terraform configuration:
   ```sh
   terraform apply
   ```

## Backend Configuration

The Terraform state is stored in an S3 bucket. The backend configuration is defined in

versions.tf

```terraform
terraform {
  backend "s3" {
    bucket = "yourbucket"
    key    = "terraform/ovh-project"
    region = "eu-central-1"
  }
}
```

## Providers

The required providers are defined in

versions.tf

```terraform
terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "1.5.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.65.0 |
| <a name="requirement_ovh"></a> [ovh](#requirement\_ovh) | 1.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ovh_cloud_project.cloud_project](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/resources/cloud_project) | resource |
| [ovh_iam_policy.admin](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/resources/iam_policy) | resource |
| [ovh_iam_policy.editor](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/resources/iam_policy) | resource |
| [ovh_iam_policy.reader](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/resources/iam_policy) | resource |
| [ovh_me.myaccount](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/data-sources/me) | data source |
| [ovh_me_identity_user.user](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/data-sources/me_identity_user) | data source |
| [ovh_me_identity_users.users](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/data-sources/me_identity_users) | data source |
| [ovh_order_cart.mycart](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/data-sources/order_cart) | data source |
| [ovh_order_cart_product_plan.cloud](https://registry.terraform.io/providers/ovh/ovh/1.5.0/docs/data-sources/order_cart_product_plan) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | this is for the tfstates Backend. in our case AWS. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Projects last block in name | `string` | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | Users and their roles provided by meshStack (Note that users must exist in stackit) | <pre>list(object(<br>    {<br>      meshIdentifier = string<br>      username       = string<br>      firstName      = string<br>      lastName       = string<br>      email          = string<br>      euid           = string<br>      roles          = list(string)<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | Projects first block in name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ovh_login_link"></a> [ovh\_login\_link](#output\_ovh\_login\_link) | n/a |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | n/a |
<!-- END_TF_DOCS -->
