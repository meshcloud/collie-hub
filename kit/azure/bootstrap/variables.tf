variable "service_principal_name" {
  type        = string
  description = "name of the Service Principal for deploying the cloud foundation"
  default     = "cloudfoundation_tf_deploy_user"
}

variable "aad_tenant_id" {
  type        = string
  description = "Id of the AAD Tenant. This is also the simultaneously the id of the root management group."
}

variable "service_principal_credentials_file" {
  type        = string
  description = "location of the credentials file to generate. This file will contain credentials for authenticating the service principal."
}
