variable "location" {
  type        = string
  nullable    = false
  description = "Azure location for deploying the storage account"
}

variable "terraform_state_config_file_path" {
  type        = string
  nullable    = false
  description = "tfstate-config file for running the bootstrap"
}

variable "cloudfoundation" {
  type        = string
  nullable    = false
  description = "tfstate resource group for the statefiles"
}

variable "spn_docs_readonly" {
  type        = bool
  description = "here you can activate a read-only user for the states to host the documentation or activate a drift detection pipeline"
  default     = false
}

variable "uami_documentation_spn" {
  type        = bool
  description = "here you can activate a read-only user for the states to host the documentation or activate a drift detection pipeline"
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
