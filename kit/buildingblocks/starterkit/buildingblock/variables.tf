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

variable "subscription_id" {
  type = string
}

variable "location" {
  type    = string
  default = "westeurope"
}
