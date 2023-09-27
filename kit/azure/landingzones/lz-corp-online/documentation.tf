output "documentation_md" {
  value = <<EOF
# Corp and Online Landing Zones

Online: This is the dedicated Management Group for Online landing zones, meaning workloads that may require direct internet inbound/outbound connectivity or also for workloads that may not require a VNet.

Corp: This is the dedicated Management Group for Corp landing zones, meaning workloads that requires connectivity/hybrid connectivity with the corporate network thru the hub in the connectivity subscription.

Landing zones for application teams are placed under either 
- **${resource.azurerm_management_group.online.display_name}** - landing zones with internet access
- **${resource.azurerm_management_group.corp.display_name}** - landing zones with on-prem network access

### Active Policies

#### Service and Location Restrictions
EOF
}
