variable "service_principal_name" {
  type        = string
  description = "name of the Service Principal for deploying the cloud foundation"
  default     = "cloudfoundation_tf_deploy_user"
}

variable "aad_tenant_id" {
  type        = string
  description = "Id of the AAD Tenant. This is also the simultaneously the id of the root management group."
}

variable "terraform_state_storage" {
  type = object({
    location = string
  })
  nullable    = true
  default     = null
  description = "Configure this object to enable setting up a terraform state store in Azure Storage."
}

variable "platform_engineers_members" {
  description = "Platform engineers with access to this platform's terraform state"
  type = list(object({
    email = string,
    upn   = string,
  }))
}

variable "file_path" {
  type        = string
  default     = "tfstates-config.yml"
  description = "tfstate-config file for running the bootstrap"
}

variable "resources_tfstate" {
  type        = string
  nullable    = false
  description = "tfstate resource group for the statefiles"
}
