variable "aws_region" {
  type = string
}

variable "aws_root_account_id" {
  type = string
}

variable "billing_users" {
  description = "The list of user principals that shall be granted billing access"
  type = list(object({
    principal_id = string, # Note: currently its not possible to look up users by username with AWS SSO via terraform, we have to hardcode the ids.
    email        = string,
  }))
  default = []
}


variable "aws_sso_instance_arn" {
  type        = string
  description = "best retrieved via tolist(data.aws_ssoadmin_instances.$xxx.arns)[0]"
}
