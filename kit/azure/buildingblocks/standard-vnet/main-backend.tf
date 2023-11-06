variable "create_new_storageaccount" {
  type        = number
  description = "If you already have an Storage Account to keep your terraform state file in you environment insert '1', otherwise insert '0' so a new one will be created"
  validation {
    condition     = var.create_new_storageaccount == 1 || var.create_new_storageaccount == 0
    error_message = "create_new_spn variable must be either 0 or 1."
  }
}

variable "existing_storage_account_id" {
  type = string
  description = "'Only required if you want to re-use an existing storage account. This is the resourceId of an existing storage account. You can retrieve this value from panel."
  default = null
}

variable "new_resource_group_name" {
  type = string
  description = "Name of the resource group to create a new storage account inside this RG"
  default = null
}

module "existing_sta" {
  count                       = var.create_new_storageaccount == 1 ? 1 : 0
  source                      = "./module-existing-storage-account"
  storage_account_resource_id = var.existing_storage_account_id
}

module "new_sta" {
  count               = var.create_new_storageaccount == 0 ? 1 : 0
  source              = "./module-new-storage-account"
  resource_group_name = var.new_resource_group_name
}



output "existing_sta_backend" {
  value     = module.existing_sta
  sensitive = true
}

output "new_sta_backend" {
  value = module.new_sta
  sensitive = true
}
