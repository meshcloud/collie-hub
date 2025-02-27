variable "api_url" {
  description = "Base API URL"
  type        = string
  default     = "https://authorization.api.stackit.cloud"
}

variable "token" {
  description = "Bearer token for authentication"
  type        = string
  sensitive   = true
}

variable "workspace_id" {
  type        = string
  description = "Projects first block in name"
}

variable "organization_id" {
  type        = string
  description = "id of the organization"
}

variable "project_id" {
  type        = string
  description = "Projects last block in name"
}

variable "parent_container_id" {
  type        = string
  description = "The stackit Cloud parent container id for the project"
}

variable "aws_account_id" {
  description = "this is for the tfstates Backend. in our case AWS."
  type        = string
}

variable "users" {
  type = list(object(
    {
      meshIdentifier = string
      username       = string
      firstName      = string
      lastName       = string
      email          = string
      euid           = string
      roles          = list(string)
    }
  ))
  description = "Users and their roles provided by meshStack (Note that users must exist in stackit)"
}
