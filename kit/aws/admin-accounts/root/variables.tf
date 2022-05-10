variable "aws_region" {
  type = string
}

variable "aws_root_account_id" {
  type = string
}

variable "billing_users" {
  description = "The list of user principals that shall be granted billing access"
  type = list(object({
    principal_id = string,
    email        = string,
  }))
  default = []
}
