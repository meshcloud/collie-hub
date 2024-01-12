variable "hub_rg" {
  type        = string
  description = "Resource Group name for the hub."
}

variable "hub_vnet" {
  type        = string
  description = "Virtual Network name for the hub."
}

variable "location" {
  type        = string
  description = "Azure region where the resources will be deployed."
}

variable "tenant_name" {
  type        = string
  description = "Name to identify the resources."
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network in CIDR notation."
}

variable "connectivity_rg" {
  type        = string
  description = "Resource Group name for the connectivity resources."
}

variable "azurerm_firewall" {
  type        = string
  description = "Azure Firewall name"
  default     = null
}

variable "rule_priority" {
  type        = number
  default     = 200
  description = "Azure Firewall rule priority"
}

variable "firewall_network_rules" {
  description = "List of network rules to apply to the firewall."
  type = list(object({
    name                  = string
    action                = string
    source_addresses      = list(string)
    destination_ports     = list(string)
    destination_addresses = list(string)
    protocols             = list(string)
  }))
  default = []
}

variable "firewall_application_rules" {
  description = "List of application rules to apply to the firewall."
  type = list(object({
    name             = string
    action           = string
    source_addresses = list(string)
    target_fqdns     = list(string)
    protocol = object({
      type = string
      port = string
    })
  }))
  default = []
}

variable "firewall_nat_rules" {
  description = "List of NAT rules to apply to the firewall."
  type = list(object({
    name                  = string
    action                = string
    source_addresses      = list(string)
    destination_ports     = list(string)
    destination_addresses = list(string)
    protocols             = list(string)
    translated_address    = string
    translated_port       = string
  }))
  default = []
}
