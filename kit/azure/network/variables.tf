## HUB Variables

variable "location" {
  description = "Location of the network"
  type        = string
  default     = "germanywestcentral"
}

variable "hub-vnet-rg" {
  type        = string
  description = "The resource group name holding the hub vnet"
  default     = "hub-rg"
}

variable "hub-vnet" {
  type        = string
  description = "The name of the hub virtual network"
  default     = "hub-vnet"
}

variable "hub-route-table" {
  type        = string
  description = "Name of the route table in the hub network"
  default     = "hub-route-table"
}

variable "admin_password" {
  type        = string
  description = "The password of the administrator of the linux VM."
  sensitive   = true
  validation {
    condition     = length(var.admin_password) >= 8
    error_message = "Password must be at least 8 characters long"
  }
  validation {
    condition     = can(regex("^(?:(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])|(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])|(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])|(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*])).*$", var.admin_password))
    error_message = "Password must meet at least 3 of the following criteria: uppercase letter, lowercase letter, digit, special character"
  }
}
