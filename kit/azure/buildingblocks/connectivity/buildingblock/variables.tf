variable "hub_rg" {
}

variable "hub_vnet" {
}

variable "location" {
}

variable "name" {
}

variable "address_space" {
  type = string
}

variable "subscription_id" {
  type        = string
  description = "The ID of the subscription that you want to deploy the spoke to"
}

variable "spoke_owner_principal_id" {
  type        = string
  description = "Principal id that will become owner of the spokes. Defaults to the client_id of the spoke azurerm provider."
  default     = null
}
