include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  expose = true
}

terraform {
  source = "${get_repo_root()}//kit/azure/networking"
}

dependency "bootstrap" {
  config_path = "../bootstrap"
}

dependency "organization-hierarchy" {
  config_path = "../organization-hierarchy"
}

dependency "logging" {
  config_path = "../logging"
}


generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azurerm" {
  features {}
  skip_provider_registration = true
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
  storage_use_azuread        = true


  # recommended: use a separate subscription for networking
  subscription_id = "the-id-of-your-networking-subscription"
}

provider "azuread" {
  tenant_id       = "${include.platform.locals.platform.azure.aadTenantId}"
}
EOF
}

inputs = {
  # todo: set input variables
  scope                               = dependency.organization-hierarchy.outputs.landingzones_id
  scope_network_admin                 = dependency.organization-hierarchy.outputs.parent_id
  cloudfoundation                     = include.platform.locals.cloudfoundation.name
  cloudfoundation_deploy_principal_id = dependency.bootstrap.outputs.platform_engineers_azuread_group_id
  parent_management_group_id          = dependency.organization-hierarchy.outputs.connectivity_id
  address_space                       = "10.0.0.0/16"
  location                            = "germanywestcentral"
  hub_resource_group                  = "hub-vnet-rg"
  diagnostics = {
    destination = dependency.logging.outputs.law_workspace_id
    logs        = ["all"]
    metrics     = ["all"]
  }
  netwatcher = {
    resource_group_location          = "germanywestcentral"
    log_analytics_workspace_id       = dependency.logging.outputs.law_workspace_id
    log_analytics_workspace_id_short = dependency.logging.outputs.law_workspace_id_short
    log_analytics_resource_id        = dependency.logging.outputs.law_workspace_resource_id
  }

  # In this section, we will address the creation of rules for Network Security Groups (NSGs)
  # using the example of Bastion Hosts. Each created rule is assigned a priority, with the
  # rules processed in a top-down order.

  management_nsg_rules = [
    {
      name                       = "allow-ssh"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      description                = null
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "allow-rdp"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      description                = null
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    }
  ]
  deploy_firewall   = true
  firewall_sku_tier = "Basic"

  # Application Rules:
  # Permit access to specific applications or services based on application protocols.
  # They allow traffic between specific source addresses and target FQDNs using defined protocols and ports.

  #  firewall_application_rules = [
  #    {
  #      name             = "microsoft"
  #      action           = "Allow"
  #      source_addresses = ["10.0.0.0/8"]
  #      target_fqdns     = ["*.microsoft.com"]
  #      protocol = {
  #        type = "Http"
  #        port = "80"
  #      }
  #    },
  #  ]

  # Network Rules:
  # Enable traffic between source and destination addresses over specific ports and protocols.
  # Typically operate at the network level, allowing access to specific services like NTP (Network Time Protocol)
  # over UDP port 123, for example.

  #  firewall_network_rules = [
  #    {
  #      name                  = "ntp"
  #      action                = "Allow"
  #      source_addresses      = ["10.0.0.0/8"]
  #      destination_ports     = ["123"]
  #      destination_addresses = ["*"]
  #      protocols             = ["UDP"]
  #    },
  #  ]

  # NAT Rules (Network Address Translation):
  # Control the translation of IP addresses and ports in network traffic.
  # These rules facilitate the redirection of inbound or outbound traffic by modifying source or destination
  # addresses and/or ports.
  # In the given example, traffic from source address 192.168.1.0/24 reaching TCP port 80 is redirected
  # to the destination address public_ip with port 8080.

  #  firewall_nat_rules = [
  #    {
  #      name                  = "nat-rule-1"
  #      action                = "Dnat"  # Could be "DNAT" or "SNAT" based on your requirement
  #      source_addresses      = ["192.168.1.0/24"]
  #      destination_ports     = ["80"]
  #      destination_addresses = ["public_ip"]
  #      protocols             = ["TCP"]
  #      translated_address    = "10.0.0.1"
  #      translated_port       = "8080"
  #
  #    }
  #  ]
}
