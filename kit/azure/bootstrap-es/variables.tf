variable "foundation_name" {
  type = string
}

## variables for sp resources
variable "root_parent_id" {
  type = string
  description = "The root_parent_id is used to specify where to set the root for all Landing Zone deployments. Usually the Tenant ID"
}

variable "service_principal_name" {
  type        = string
  description = "name of the Service Principal for deploying the cloud foundation"
  default     = "cloudfoundation_tf_deploy_user"
}

## variables for tfstate resources
variable "storage_account_name" {
  type        = string
  description = "Name of storage account used as terraform backend"
}

variable "storage_rg_name" {
  type        = string
  description = "Name of resource group holding the storage account used as terraform backend"
  default     = "tfstate"
}

variable "tfstate_location" {
  type        = string
  description = "location of tfstate resource group"
}

## variables for group resources

variable "platform_engineers_members" {
  description = "User principal name of platform engineers with access to this platform's terraform state"
  type = list(string)
}
