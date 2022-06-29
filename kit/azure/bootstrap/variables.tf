variable "service_principal_name" {
  type        = string
  description = "name of the Service Principal for deploying the cloud foundation"
  default     = "cloudfoundation_tf_deploy_user"
}

variable "aad_tenant_id" {
  type        = string
  description = "Id of the AAD Tenant. This is also the simultaneously the id of the root management group."
}
