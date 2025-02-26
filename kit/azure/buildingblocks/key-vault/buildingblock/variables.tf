variable "key_vault_name" {
  type        = string
  nullable    = false
  description = "The name of the key vault."
}

variable "key_vault_resource_group_name" {
  type        = string
  nullable    = false
  description = "The name of the resource group containing the key vault."
}

variable "location" {
  type        = string
  description = "The location/region where the key vault is created."
}

variable "subscription_id" {
  type = string
}

variable "users" {
  type = list(object(
    {
      meshIdentifier = string
      username       = string
      firstName      = string
      lastName       = string
      email          = string
      euid           = string
      roles          = list(string)
    }
  ))
  description = "Users and their roles provided by meshStack (Note that users must exist in stackit)"
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}
