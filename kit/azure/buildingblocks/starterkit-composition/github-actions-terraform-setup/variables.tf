variable "repo_name" {
  type        = string
  description = "Name of the repository to connect."
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
  description = "The subscription id to which this building will be deployed."
}

variable "location" {
  type    = string
  default = "westeurope"
}

