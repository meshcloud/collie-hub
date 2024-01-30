locals {
  diag_resource_list = var.diagnostics != null ? split("/", var.diagnostics.destination) : []
  parsed_diag = var.diagnostics != null ? {
    log_analytics_id   = contains(local.diag_resource_list, "Microsoft.OperationalInsights") ? var.diagnostics.destination : null
    storage_account_id = contains(local.diag_resource_list, "Microsoft.Storage") ? var.diagnostics.destination : null
    event_hub_auth_id  = contains(local.diag_resource_list, "Microsoft.EventHub") ? var.diagnostics.destination : null
    metric             = var.diagnostics.metrics
    log                = var.diagnostics.logs
    } : {
    log_analytics_id   = null
    storage_account_id = null
    event_hub_auth_id  = null
    metric             = []
    log                = []
  }

  # default_nsg_rule = {
  #   direction                                  = "Inbound"
  #   access                                     = "Allow"
  #   protocol                                   = "Tcp"
  #   description                                = null
  #   source_port_range                          = null
  #   source_port_ranges                         = null
  #   destination_port_range                     = null
  #   destination_port_ranges                    = null
  #   source_address_prefix                      = null
  #   source_address_prefixes                    = null
  #   source_application_security_group_ids      = null
  #   destination_address_prefix                 = null
  #   destination_address_prefixes               = null
  #   destination_application_security_group_ids = null
  # }

  default_mgmt_nsg_rules = [
    {
      name                       = "allow-load-balancer"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
    },
    {
      name                       = "deny-other"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    }
  ]

  merged_mgmt_nsg_rules = flatten([
    for nsg in var.management_nsg_rules : merge(nsg)
  ])

  public_ip_map = { for pip in var.public_ip_names : pip => true }
  mgmt_ip_name  = "fw-mgmt"


  application_rules = {
    for idx, rule in var.firewall_application_rules : rule.name => {
      idx : idx,
      rule : rule,
    }
  }

  network_rules = {
    for idx, rule in var.firewall_network_rules : rule.name => {
      idx : idx,
      rule : rule,
    }
  }

  nat_rules = {
    for idx, rule in var.firewall_nat_rules : rule.name => {
      idx : idx,
      rule : rule,
    }
  }
}
