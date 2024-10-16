variable "repo_name" {
  type    = string
  default = "name of the created repository"
}

variable "visibility" {
  type    = string
  default = "private"
}

variable "template_owner" {
  type = string
}

variable "template_repo" {
  type = string
}

variable "workspace_identifier" {
  type = string
}

variable "project_identifier" {
  type = string
}

# this variable is supposed to be used by an injected config.tf file for configuring the azurerm provider
# tflint-ignore: terraform_unused_declarations
variable "subscription_id" {
  type        = string
  description = "the subscription id to which this building block shall be deployed"
}

variable "location" {
  type    = string
  default = "westeurope"
}
