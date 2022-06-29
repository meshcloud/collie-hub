variable "aws_root_account_id" {
  type        = string
  description = "The id of your AWS Organization's root account"
}

variable "iam_user_name" {
  type        = string
  description = "name of the AWS IAM user"
  default     = "cloudfoundation_tf_deploy_user"
}
