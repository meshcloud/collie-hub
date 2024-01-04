variable "scope" {
  type        = string
  description = "ID of the management group that you want to manage spokes in"
}

variable "scope_network_admin" {
  type        = string
  description = "ID of the management group that you want to manage spokes in"
}

variable "cloudfoundation" {
  type        = string
  nullable    = false
  description = "this is the name of your cloud foundation"
}

variable "cloudfoundation_deploy_principal_id" {
  type        = string
  description = "Principal ID for deploying Cloud Foundation resources"
}

variable "parent_management_group_id" {
  type        = string
  description = "ID of the parent management group"
}

variable "location" {
  type        = string
  description = "Location/region for deploying resources"
}

variable "address_space" {
  type        = string
  description = "List of address spaces for the virtual networks"
}

variable "hub_vnet_name" {
  type        = string
  default     = "hub-vnet"
  description = "Name of the hub virtual network"
}

variable "netwatcher" {
  description = "Properties for creating network watcher. If set it will create Network Watcher resource using standard naming standard."
  type = object({
    #resource_group_location    = string
    log_analytics_workspace_id       = string
    log_analytics_workspace_id_short = string
    log_analytics_resource_id        = string
  })
  default = null
}

variable "management_nsg_rules" {
  description = "Network security rules to add to management subnet. See README for details on how to setup."
  type        = list(any)
  default     = []
}

variable "lz_networking_deploy" {
  type        = string
  default     = "cloudfoundation_lz_network_deploy_user"
  description = "Service Principal responsible for deploying the landing zone networking"
}

variable "hub_networking_deploy" {
  type        = string
  default     = "cloudfoundation_hub_network_deploy_user"
  description = "Service Principal responsible for deploying the hub networking"
}

variable "network_admin_group" {
  type        = string
  default     = "cloudfoundation-network-admins"
  description = "Name of the Cloud Foundation network admin group"
}

variable "hub_resource_group" {
  type        = string
  default     = "hub-vnet-rg"
  description = "Name of the hub resource group"
}

variable "create_ddos_plan" {
  description = "Create a DDos protection plan and attach to vnet."
  type        = bool
  default     = false
}

variable "diagnostics" {
  description = "Diagnostic settings for those resources that support it. See README.md for details on configuration."
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
  description = "Specifies the number of bits of the prefix. The value can be set between 24 (256 addresses) and 31 (2 addresses)."
  type        = number
  default     = 30
}

variable "mgmt_ip_names" {
  description = "Public ips is a list of ip names that are connected to the firewall. At least one is required."
  type        = list(string)
  default = [
    "fw-mgmt"
  ]

}

variable "public_ip_names" {
  description = "Public ips is a list of ip names that are connected to the firewall. At least one is required."
  type        = list(string)
  default = [
    "fw-public"
  ]

}

variable "firewall_zones" {
  description = "A collection of availability zones to spread the Firewall over."
  type        = list(string)
  default     = null
}

variable "firewall_sku_tier" {
  description = "Basic, Standard ... "
  type        = string
  default     = "Standard"
}

variable "firewall_bool" {
  description = "firewall off"
  type        = bool
  default     = false
}

variable "threat_intel_mode" {
  description = "The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert, Deny and \"\"(empty string)."
  type        = string
  default     = "Off"
}
