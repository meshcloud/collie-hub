output "documentation_md" {
  value = <<EOF
# Sandbox Landing Zone

A sandbox landing zone is a pre-configured environment that is specifically designed for learning and experimentation
with Azure. Sandboxes are strictly treated as **ephemeral** environments that must be torn down after an experiment
has concluded.

> ⚠️ It is **forbidden** to use sandbox landing zones with data classified as "internal" or higher confidentiality level.

This landing zone places a few restrictions on Azure Services that are not deemed suitable for experimentation.

This landing zone intergrates below the `online` management group in the [organization hierarchy](../azure-organization-hierarchy.md).

The resource hierarchy of this landing zone looks like this:

```md
`${resource.azurerm_management_group.sandbox.display_name}` management group for sandbox landing zone
   └── *application team subscriptions*
```

## Active Policies

### Service and Location Restrictions

|Policy|Effect|Description|Rationale|
|-|-|-|-|
|[${module.policy_sandbox.policy_assignments["Enforce-ALZ-Sandbox"].display_name}](https://cloudfoundation.org/maturity-model/tenant-management/playground-sandbox-environments.html#why-use-a-sandbox-environment)|Deny|${module.policy_sandbox.policy_assignments["Enforce-ALZ-Sandbox"].description}|Forbids use of certain Azure Services that are unsuitable for experimentation environments because they incur high cost and/or allow establishing non-zero-trust connectivity via VNet peering to other services.<br>The following services are forbidden:<br>${join("<br>", formatlist("- `%s`", module.policy_sandbox.policy_assignments["Enforce-ALZ-Sandbox"].parameters.listOfResourceTypesNotAllowed.value))}|
EOF
}
