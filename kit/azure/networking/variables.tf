variable "connectivity_scope" {
  type        = string
  description = "Identifier for the management group connectivity"
}

variable "landingzone_scope" {
  type        = string
  description = "Identifier for the management group landinzone"
}

variable "cloudfoundation" {
  type        = string
  nullable    = false
  description = "Name of your cloud foundation"
}

variable "location" {
  type        = string
  description = "Region for resource deployment"
}

variable "address_space" {
  type        = string
  description = "List of address spaces for virtual networks"
}

variable "hub_vnet_name" {
  type        = string
  default     = "hub-vnet"
  description = "Name of the central virtual network"
}

variable "netwatcher" {
  description = "Properties for creating network watcher. If set, it creates a Network Watcher resource using standard naming conventions."
  type = object({
    log_analytics_workspace_id       = string
    log_analytics_workspace_id_short = string
    log_analytics_resource_id        = string
  })
  default = null
}

variable "management_nsg_rules" {
  description = "Network security rules to add to the management subnet. Refer to README for setup details."
  type        = list(any)
  default     = []
}

variable "network_admin_group" {
  type        = string
  default     = "cloudfoundation-network-admins"
  description = "Name of the Cloud Foundation network administration group"
}

variable "hub_resource_group" {
  type        = string
  default     = "hub-vnet-rg"
  description = "Name of the central hub resource group"
}

variable "create_ddos_plan" {
  description = "Create a DDos protection plan and attach it to the virtual network."
  type        = bool
  default     = false
}

variable "diagnostics" {
  description = "Diagnostic settings for supporting resources. Refer to README.md for configuration details."
  type = object({
    destination = string
    logs        = list(string)
    metrics     = list(string)
  })
  default = null
}

variable "service_endpoints" {
  description = "Service endpoints to add to the firewall subnet."
  type        = list(string)
  default = [
    "Microsoft.AzureActiveDirectory",
    "Microsoft.AzureCosmosDB",
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.ServiceBus",
    "Microsoft.Sql",
    "Microsoft.Storage",
  ]
}

variable "public_ip_prefix_length" {
  description = "Specifies the number of bits in the prefix. Value can be set between 24 (256 addresses) and 31 (2 addresses)."
  type        = number
  default     = 30
}

variable "public_ip_names" {
  description = "List of public IP names connected to the firewall. At least one is required."
  type        = list(string)
  default = [
    "fw-public"
  ]
}

variable "firewall_zones" {
  description = "Collection of availability zones to distribute the Firewall across."
  type        = list(string)
  default     = null
}

# https://learn.microsoft.com/en-us/azure/firewall/choose-firewall-sku
variable "firewall_sku_tier" {
  description = "Specify the tier for the firewall, choosing from options like Basic or Standard, Premium."

  type    = string
  default = "Basic"
}

variable "deploy_firewall" {
  description = "Toggle to deploy or bypass the firewall."
  type        = bool
  default     = false
}

variable "threat_intel_mode" {
  description = "Operation mode for threat intelligence-based filtering. Possible values: Off, Alert, Deny, and \"\" (empty string)."
  type        = string
  default     = "Off"
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

