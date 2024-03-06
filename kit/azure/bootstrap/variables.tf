variable "aad_tenant_id" {
  type        = string
  description = "Id of the AAD Tenant. This is also the simultaneously the id of the root management group."
}

variable "terraform_state_storage" {
  type = object({
    location         = string,
    name             = string,
    config_file_path = string
  })
  nullable    = true
  default     = null
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

variable "uami_documentation_spn" {
  type        = bool
  description = "read-only user for the states to host the documentation or activate a drift detection pipeline"
  default     = false
}

variable "uami_documentation_name" {
  type        = string
  description = "name of the Service Principal used to perform documentation and validation tasks"
  default     = "cloudfoundation_tf_docs_user"
}

variable "uami_documentation_issuer" {
  type        = string
  description = "Specifies the subject for this Federated Identity Credential, for example a github action pipeline"
  default     = "https://token.actions.githubusercontent.com"
}

variable "uami_documentation_subject" {
  type        = string
  description = "Specifies the subject for this Federated Identity Credential, for example a github action pipeline"
}
