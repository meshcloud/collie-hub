variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault"
  sensitive   = true
}

variable "key_vault_rg" {
  type        = string
  description = "Name of the Resource Group where the Key Vault is located"
  sensitive   = true
}

variable "repo_name" {
  type        = string
  default     = "github-repo"
  description = "Name of the GitHub repository"
}

variable "github_token_secret_name" {
  type        = string
  description = "Name of the secret in Key Vault that holds the GitHub token"
  sensitive   = true
}

variable "github_org" {
  type        = string
  description = "Name of the GitHub organization"
}

variable "create_new" {
  type        = bool
  description = "Flag to indicate whether to create a new repository"
}

variable "description" {
  type        = string
  default     = "created by github-repo-building-block"
  description = "Description of the GitHub repository"
}

variable "visibility" {
  type        = string
  default     = "private"
  description = "Visibility of the GitHub repository"
}

variable "use_template" {
  type        = bool
  description = "Flag to indicate whether to create a repo based on a Template Repository"
  default     = false
}

variable "template_owner" {
  type        = string
  default     = "template-owner"
  description = "Owner of the template repository"
}

variable "template_repo" {
  type        = string
  default     = "github-repo"
  description = "Name of the template repository"
}

variable "github_app_id" {
  type        = string
  description = "ID of the GitHub App"
}

variable "github_app_installation_id" {
  type        = string
  description = "Installation ID of the GitHub App"
}
