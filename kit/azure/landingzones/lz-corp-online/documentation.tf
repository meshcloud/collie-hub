output "documentation_md" {
  value = <<EOF
# Corp and Online Landing Zones

Online: This is the dedicated Management Group for Online landing zones, meaning workloads that may require direct internet inbound/outbound connectivity or also for workloads that may not require a VNet.

Corp: This is the dedicated Management Group for Corp landing zones, meaning workloads that requires connectivity/hybrid connectivity with the corporate network thru the hub in the connectivity subscription.

Landing zones for application teams are placed under either
- **${resource.azurerm_management_group.online.display_name}** - landing zones with internet access
- **${resource.azurerm_management_group.corp.display_name}** - landing zones with on-prem network access

### Active Policies Corp

#### Service and Location Restrictions
#### Centralized Audit Logs

|Policy|Effect|Description|Rationale|
|-|-|-|-|
|[${module.policy_corp.policy_assignments["Audit-PeDnsZones"].display_name}](https://cloudfoundation.org/maturity-model/security-and-compliance/centralized-audit-logs.html#proven-patterns-when-implementing-centralized-audit-logs)|Audit|
|[${module.policy_corp.policy_assignments["Deny-HybridNetworking"].display_name}](https://https://cloudfoundation.org/maturity-model/security-and-compliance/service-and-location-restrictions.html#proven-patterns-for-implementing-cloud-resource-policies)|Deny|
|[${module.policy_corp.policy_assignments["Deny-Public-Endpoints"].display_name}](https://https://cloudfoundation.org/maturity-model/security-and-compliance/service-and-location-restrictions.html#proven-patterns-for-implementing-cloud-resource-policies)|Deny|
|[${module.policy_corp.policy_assignments["Deny-Public-IP-On-NIC"].display_name}](https://https://cloudfoundation.org/maturity-model/security-and-compliance/service-and-location-restrictions.html#proven-patterns-for-implementing-cloud-resource-policies)|Deny|

### Active Policies Online

#### Service and Location Restrictions
|Policy|Effect|Description|Rationale|
|-|-|-|-|
EOF
}
