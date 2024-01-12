locals {
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

resource "azurerm_resource_group" "spoke_rg" {
  provider = azurerm.spoke
  name     = var.connectivity_rg
  location = var.location
}

resource "azurerm_virtual_network" "spoke_vnet" {
  provider            = azurerm.spoke
  name                = "${var.tenant_name}-vnet"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name
  address_space       = var.address_space
}

data "azurerm_resource_group" "hub_rg" {
  provider = azurerm.hub
  name     = var.hub_rg
}

data "azurerm_virtual_network" "hub_vnet" {
  provider            = azurerm.hub
  name                = var.hub_vnet
  resource_group_name = data.azurerm_resource_group.hub_rg.name
}

data "azurerm_firewall" "fw" {
  count               = var.azurerm_firewall != null ? 1 : 0
  provider            = azurerm.hub
  name                = var.azurerm_firewall
  resource_group_name = data.azurerm_resource_group.hub_rg.name
}

resource "azurerm_virtual_network_peering" "spoke_hub_peer" {
  provider                  = azurerm.spoke
  name                      = var.tenant_name
  resource_group_name       = azurerm_resource_group.spoke_rg.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.hub_vnet.id

  depends_on = [azurerm_virtual_network.spoke_vnet]
}


resource "azurerm_virtual_network_peering" "hub_spoke_peer" {
  provider = azurerm.hub

  name                      = var.tenant_name
  resource_group_name       = data.azurerm_resource_group.hub_rg.name
  virtual_network_name      = data.azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id

  depends_on = [azurerm_virtual_network.spoke_vnet]
}

resource "azurerm_firewall_network_rule_collection" "fw" {
  provider            = azurerm.hub
  for_each = var.azurerm_firewall != null ? local.network_rules : {}
  name                = "${var.tenant_name}_${each.key}"
  azure_firewall_name = data.azurerm_firewall.fw[0].name
  resource_group_name = data.azurerm_resource_group.hub_rg.name
  priority            = var.rule_priority * (each.value.idx + 1)
  action              = each.value.rule.action

  rule {
    name                  = "${var.tenant_name}_${each.key}"
    source_addresses      = each.value.rule.source_addresses
    destination_ports     = each.value.rule.destination_ports
    destination_addresses = [for dest in each.value.rule.destination_addresses : dest]
    protocols             = each.value.rule.protocols
  }
}

resource "azurerm_firewall_application_rule_collection" "fw" {
  provider            = azurerm.hub
  for_each = var.azurerm_firewall != null ? local.application_rules : {}
  name                = "${var.tenant_name}_${each.key}"
  azure_firewall_name = data.azurerm_firewall.fw[0].name
  resource_group_name = data.azurerm_resource_group.hub_rg.name
  priority            = var.rule_priority * (each.value.idx + 1)
  action              = each.value.rule.action

  rule {
    name             = each.key
    source_addresses = each.value.rule.source_addresses
    target_fqdns     = each.value.rule.target_fqdns

    protocol {
      type = each.value.rule.protocol.type
      port = each.value.rule.protocol.port
    }
  }
}

resource "azurerm_firewall_nat_rule_collection" "fw" {
  provider            = azurerm.hub
  for_each = var.azurerm_firewall != null ? local.nat_rules : {}
  name                = "${var.tenant_name}_${each.key}"
  azure_firewall_name = data.azurerm_firewall.fw[0].name
  resource_group_name = data.azurerm_resource_group.hub_rg.name
  priority            = var.rule_priority * (each.value.idx + 1)
  action              = each.value.rule.action

  rule {
    name                  = each.key
    source_addresses      = each.value.rule.source_addresses
    destination_ports     = each.value.rule.destination_ports
    destination_addresses = [for dest in each.value.rule.destination_addresses : dest]
    protocols             = each.value.rule.protocols
    translated_address    = each.value.rule.translated_address
    translated_port       = each.value.rule.translated_port
  }
}
