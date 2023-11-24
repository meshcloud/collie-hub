output "documentation_md" {
  value = <<EOF
# Serverless Landing Zone

A serverless landing zone is a pre-configured environment that is specifically designed for deploying serverless resources.

- **${resource.azurerm_management_group.serverless.display_name}** - this is the severless management group

### Active Policies

#### Service and Location Restrictions

|Policy|Effect|Description|Rationale|
|-|-|-|-|
|[${module.policy_serverless.policy_assignments["Enforce-ALZ-Sandbox"].display_name}](https://cloudfoundation.org/maturity-model/tenant-management/playground-sandbox-environments.html#why-use-a-sandbox-environment)|Deny|${module.policy_serverless.policy_assignments["Enforce-ALZ-Sandbox"].description}|This policy allows users to gain hands-on experience without the risk of impacting critical systems.|
EOF
}
