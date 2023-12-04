output "documentation_md" {
  value = <<EOF
# Cloud-Native Landing Zone

This landing zone is intended for cloud-native workloads. Application teams using this landing zones are responsible
for all of their workloads following the "you build it, you run it" principle.

## Active Policies

This landing zone does currently not impose any additional policies or restrictions on Subscriptions or Resources
apart from those that already apply at the [organization level](../azure-organization-hierarchy.md).

### Dev and Prod Stage Separation

We separate development and productive workloads in the cloud-native Landing Zone via two management groups.

> Currently the same policies apply to development and productive workloads. However, the cloud foundation team may decide
> to introduce more differences in the future.

This landing zone intergrates below the `online` management group in the [organization hierarchy](../azure-organization-hierarchy.md).

The resource hierarchy of this landing zone looks like this:

```md
`${resource.azurerm_management_group.cloudnative.display_name}` management group for cloud-native landing zone
  ├── `${resource.azurerm_management_group.dev.display_name}` management group for development workloads
  │  └── *application team subscriptions*
  └── `${resource.azurerm_management_group.prod.display_name}` management group for production workloads
     └── *application team subscriptions*
```

|Policy|Effect|Description|Rationale|
|-|-|-|-|
|[${module.policy_cloudnative.policy_assignments["Allow-Cloudnative-Only"].display_name}](https://cloudfoundation.org/maturity-model/tenant-management/cloud-native-landing-zone.html#best-practices-for-designing-and-building-a-cloud-native-landing-zone)|Deny|${module.policy_cloudnative.policy_assignments["Allow-Cloudnative-Only"].description}|This policy allows only Cloud-Native resources to be deployed.|

EOF
}
