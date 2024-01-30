output "documentation_md" {
  value = <<EOF
# Azure ${module.connectivity.tenant_name}

this Tenant has following building blocks
 - subscription
 - connectivity

## Tenant Responsibiltiy
 - NAME-HERE

## Landingzone Managment Group
 - ${module.subscription.landingzone_managment_group}

# Firewall Rules
${module.connectivity.firewall_name != null ?
  "## Firewall: `${module.connectivity.firewall_name}` Application Rules for `${module.connectivity.tenant_name}`\n| Name | Action | Source Addresses | Target FQDNs | Protocol |\n|-|-|-|-|-|\n${join("\\n", [for rule in module.connectivity.fw_spoke_application_rules : "| ${module.connectivity.tenant_name}_${rule.name} | ${rule.action} | ${join(", ", rule.source_addresses)} | ${join(", ", rule.target_fqdns)} | ${rule.protocol.type} (${rule.protocol.port}) |"])}\n" : ""}

${module.connectivity.firewall_name != null ?
  "## Firewall: `${module.connectivity.firewall_name}` Network Rules for `${module.connectivity.tenant_name}`\n| Name | Action | Source Addresses | Destination Ports | Destination Addresses | Protocols |\n|-|-|-|-|-|-|\n${join("\\n", [for rule in module.connectivity.fw_spoke_network_rules : "| ${module.connectivity.tenant_name}_${rule.name} | ${rule.action} | ${join(", ", rule.source_addresses)} | ${join(", ", rule.destination_ports)} | ${join(", ", rule.destination_addresses)} | ${join(", ", rule.protocols)} |"])}\n" : ""}

${module.connectivity.firewall_name != null ?
"## Firewall: `${module.connectivity.firewall_name}` Nat Rules for `${module.connectivity.tenant_name}`\n| Name | Action | Source Addresses | Destination Ports | Destination Addresses | Protocols | Translated Address | Translated Port |\n|-|-|-|-|-|-|-|-|\n${join("\n", [for rule in module.connectivity.fw_spoke_nat_rules : "| ${module.connectivity.tenant_name}_${rule.name} | ${rule.action} | ${join(", ", rule.source_addresses)} | ${join(", ", rule.destination_ports)} | ${join(", ", rule.destination_addresses)} | ${join(", ", rule.protocols)} | ${rule.translated_address} | ${rule.translated_port} |"])}\n" : ""}
EOF
}
