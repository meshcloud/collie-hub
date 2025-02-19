
output "documentation_md" {
  value = <<-EOF
# Networking

Connection to the hub is the pre-requisite for getting access to the on-prem network.

The hub itself has the following address space `${var.address_space}`.

Upon request, we will peer a VNet in your subscription with the hub.

All Firewall related logs are in the Log Anlytics Workspace
  - `${local.parsed_diag.log_analytics_id}`

## Hub and spoke vnet-peering
| name | address_space | description |
|-|-|-|
| glaskugel | 10.1.0.0/24 | Project Palantíri, stackholder Saruman |
| glaskugel | 10.2.1.0/24 | Project Palantíri dev, stackholder Saruman |
## Subnets

| name | prefixes |
|-|-|
| ${azurerm_subnet.mgmt.name} | ${join(", ", azurerm_subnet.mgmt.address_prefixes)} |
| ${azurerm_subnet.gateway.name} | ${join(", ", azurerm_subnet.gateway.address_prefixes)} |
${var.deploy_firewall ? "| ${azurerm_subnet.firewall[0].name} | ${join(", ", azurerm_subnet.firewall[0].address_prefixes)} |" : ""}


${var.deploy_firewall ? "## Azure Firewall sku: ${var.firewall_sku_tier}" : "## Firewall deployment is not enabled."}
${var.firewall_sku_tier == "Basic" && var.deploy_firewall ?
  "Azure Firewall mgmt IP and AzureFirewallManagementSubnet and Management IP only exist in the Basic SKU" : ""}

## Network Security Group ${azurerm_subnet.mgmt.name}
| Name | Direction | Access | Protocol | Source Port Range | Destination Port Range | Source Address Prefix | Destination Address Prefix |
|-|-|-|-|-|-|-|-|
${join("\n", [for rule in var.management_nsg_rules : "| ${rule.name} | ${rule.direction} | ${rule.access} | ${rule.protocol} | ${rule.source_port_range} | ${rule.destination_port_range} | ${rule.source_address_prefix} | ${rule.destination_address_prefix} |"])}

${var.deploy_firewall ?
  "## Application Rules for ${azurerm_firewall.fw[0].name}\n| Name | Action | Source Addresses | Target FQDNs | Protocol |\n|-|-|-|-|-|\n${join("\\n", [for rule in var.firewall_application_rules : "| ${rule.name} | ${rule.action} | ${join(", ", rule.source_addresses)} | ${join(", ", rule.target_fqdns)} | ${rule.protocol.type} (${rule.protocol.port}) |"])}\n" : ""}

${var.deploy_firewall ?
  "## Network Rules for ${azurerm_firewall.fw[0].name}\n| Name | Action | Source Addresses | Destination Ports | Destination Addresses | Protocols |\n|-|-|-|-|-|-|\n${join("\\n", [for rule in var.firewall_network_rules : "| ${rule.name} | ${rule.action} | ${join(", ", rule.source_addresses)} | ${join(", ", rule.destination_ports)} | ${join(", ", rule.destination_addresses)} | ${join(", ", rule.protocols)} |"])}\n" : ""}

${var.deploy_firewall ?
"## Nat Rules for ${azurerm_firewall.fw[0].name}\n| Name  | Action | Source Addresses | Destination Ports | Destination Addresses | Protocols | Translated Address | Translated Port |\n|-|-|-|-|-|-|-|-|\n${join("\n", [for rule in var.firewall_nat_rules : "| ${rule.name} | ${rule.action} | ${join(", ", rule.source_addresses)} | ${join(", ", rule.destination_ports)} | ${join(", ", rule.destination_addresses)} | ${join(", ", rule.protocols)} | ${rule.translated_address} | ${rule.translated_port} |"])}\n" : ""}

Access to the central Network Hub is granted on a need-to-know basis to Auditors and Cloud Foundation Team members.
The following Entra ID groups control access and are used to implement [Privileged Access Management](./azure-pam.md).

|group|description|
|-|-|
| ${azuread_group.network_admins.display_name} | ${azuread_group.network_admins.description} |

EOF
}

