variable "parent_management_group_name" {
  type        = string
  description = "Name of the management group you want to use as parent for your foundation."
}

variable "terraform_state_storage" {
  type = object({
    location            = string,
    name                = string,
    config_file_path    = string,
    resource_group_name = optional(string)
  })
  nullable    = false
  description = "Configure this object to enable setting up a terraform state store in Azure Storage."
}

variable "platform_engineers_members" {
  description = "Set up a group of platform engineers. If enabled, this group will receive access to terraform_state_storage"
  type = list(object({
    email = string,
    upn   = string,
  }))
}

variable "platform_engineers_group" {
  type        = string
  default     = "cloudfoundation-platform-engineers"
  description = "the name of the cloud foundation platform engineers group"
}

variable "documentation_uami" {
  type = object({
    name = string
    # note: it seems wildcards are not supported yet, see https://github.com/Azure/azure-workload-identity/issues/373
    oidc_subject = string
  })
  description = "read-only UAMI with access to terraform states to generate documentation in CI pipelines"
  default     = null
}


variable "validation_uami" {
  type = object({
    name = string
    # note: it seems wildcards are not supported yet, see https://github.com/Azure/azure-workload-identity/issues/373
    oidc_subject = string
  })
  description = "read-only UAMI with access to terraform states and read-only access on the landingzone architecture for validation of the deployment in CI pipelines"
  default     = null
}
