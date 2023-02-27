
# Azure Resource Group Name 
variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
  default = "rg-default"  
}

# Azure Resources Location
variable "resource_group_location" {
  description = "Region in which Azure Resources to be created"
  type = string
  default = "West Europe"  
}

variable "aadTenantId" {
  type = string
}

variable "keyvault_user_object_id" {
  type = map
}