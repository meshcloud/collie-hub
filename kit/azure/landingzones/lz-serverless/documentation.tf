output "documentation_md" {
  value = <<EOF
# Serverless Landing Zone

This landing zone is intended for serverless resources.

- **${resource.azurerm_management_group.serverless.display_name}** - this is the severless management group

### Active Policies

#### Service and Location Restrictions

|Policy|Effect|Description|Rationale|
|-|-|-|-|
|[${module.policy_serverless.policy_assignments["Allow-Serverless-Only"].display_name}](https://cloudfoundation.org/maturity-model/tenant-management/cloud-native-landing-zone.html#best-practices-for-designing-and-building-a-cloud-native-landing-zone)|Deny|
EOF
}
