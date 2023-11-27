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
|[${module.policy_corp.policy_assignments["Audit-PeDnsZones"].display_name}](https://cloudfoundation.org/maturity-model/security-and-compliance/centralized-audit-logs.html#proven-patterns-when-implementing-centralized-audit-logs)|Audit|${module.policy_corp.policy_assignments["Audit-PeDnsZones"].description}|This policy helps to ensure that Private Link Private DNS Zone resources are deployed correctly and securely. By auditing the deployment of these resources, we can identify any potential issues or vulnerabilities and take corrective action to mitigate them.|
|[${module.policy_corp.policy_assignments["Deploy-Private-DNS-Zones"].display_name}](https://https://cloudfoundation.org/maturity-model/security-and-compliance/service-and-location-restrictions.html#proven-patterns-for-implementing-cloud-resource-policies)|Deploy| ${module.policy_corp.policy_assignments["Deploy-Private-DNS-Zones"].description} |This policy helps to ensure that Azure PaaS services are integrated with Azure Private DNS zones, which provides a reliable, secure DNS service to manage and resolve domain names in a virtual network without the need to add a custom DNS solution.|
|[${module.policy_corp.policy_assignments["Deny-HybridNetworking"].display_name}](https://https://cloudfoundation.org/maturity-model/security-and-compliance/service-and-location-restrictions.html#proven-patterns-for-implementing-cloud-resource-policies)|Deny|${module.policy_corp.policy_assignments["Deny-HybridNetworking"].description}|By denying these resources, we can ensure that all traffic to and from the resource is routed through the private network, which is more secure.|
|[${module.policy_corp.policy_assignments["Deny-Public-Endpoints"].display_name}](https://https://cloudfoundation.org/maturity-model/security-and-compliance/service-and-location-restrictions.html#proven-patterns-for-implementing-cloud-resource-policies)|Deny|${module.policy_corp.policy_assignments["Deny-Public-Endpoints"].description} | By disabling public network access, we can ensure that all traffic to and from the resource is routed through the private network, which is more secure.|
|[${module.policy_corp.policy_assignments["Deny-Public-IP-On-NIC"].display_name}](https://https://cloudfoundation.org/maturity-model/security-and-compliance/service-and-location-restrictions.html#proven-patterns-for-implementing-cloud-resource-policies)|Deny|${module.policy_corp.policy_assignments["Deny-Public-IP-On-NIC"].description}|By denying public IP addresses, we can ensure that all traffic to and from the resource is routed through the private network, which is more secure.|

### Active Policies Online

#### Service and Location Restrictions
|Policy|Effect|Description|Rationale|
|-|-|-|-|
EOF
}
