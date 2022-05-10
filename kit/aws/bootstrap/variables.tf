variable "aws_root_account_id" {
  type        = string
  description = "The id of your AWS Organization's root account"
}

variable "iam_user_name" {
  type        = string
  description = "name of the AWS IAM user"
  default     = "cloudfoundation_tf_deploy_user"
}

variable "aws_shared_credentials_file" {
  type        = string
  description = "path of the aws_shared_credentials_file to generate containing credentials for authenticating the deploy user"
}

variable "repository_root" {
  type        = string
  description = "path of the repository root, i.e. terragrunt $get_repo_root()"
}
