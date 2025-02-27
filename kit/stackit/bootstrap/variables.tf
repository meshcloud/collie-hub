variable "platform_admins" {
  description = "List of members to add with their roles and subjects"
  type = list(object({
    role    = string
    subject = string
  }))
}

variable "platform_users" {
  description = "List of members to add with their roles and subjects"
  type = list(object({
    role    = string
    subject = string
  }))
}

variable "token" {
  description = "Bearer token for authentication"
  type        = string
  sensitive   = true
}

variable "api_url" {
  description = "Base API URL"
  type        = string
  default     = "https://authorization.api.stackit.cloud"
}

variable "organization_id" {
  description = "Organization ID of your stackit cloud account"
  type        = string
}
