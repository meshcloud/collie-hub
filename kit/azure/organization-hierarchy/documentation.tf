output "documentation_md" {
  value = <<EOF
# Azure Organization Hierarchy

We leverage the Azure Resource Hierarchy to define and enforce global policies
across our entire organization.

## Management Group Hierarchy

The management group hierarchy allows us to selectively apply policies.
The main hierarchy looks like this

```md
`${resource.azurerm_management_group.parent.display_name}` this is the root of the hierarchy
├──  `${resource.azurerm_management_group.landingzones.display_name}` landing zones for application teams
│  ├── `${resource.azurerm_management_group.online.display_name}` landing zones with internet access
│  └── `${resource.azurerm_management_group.corp.display_name}` landing zones with on-prem network access
└── `${resource.azurerm_management_group.platform.display_name}` landing zones for platform-level workloads, restriced access only for cloud foundation team
```

Landing zones for application teams are placed under either `${resource.azurerm_management_group.corp.display_name}` or `${resource.azurerm_management_group.online.display_name}`.
See [Application Landing Zones](#application-landing-zones) below.

> TODO: link to individual landing zone documentation deployed in your foundations from here.

## Global Policies

This table describes global policies consistently enforced for all workloads running on Azure.

These policies are assigned to the `${resource.azurerm_management_group.parent.display_name}` management group.

### Activity Logs

Global policies enforce auditing of all subscription-level Azure API events. Please see [Activity Logs](./azure-activity-logs.md) for more details.

### Service and Location Restrictions

|Policy|Effect|Description|Rationale|
|-|-|-|-|
|[${module.policy_root.policy_assignments["Deny-Classic-Resources"].display_name}](https://www.azadvertizer.net/azpolicyadvertizer/6c112d4e-5bc7-47ae-a041-ea2d9dccd749.html)|Deny|${module.policy_root.policy_assignments["Deny-Classic-Resources"].description}|Azure classic resources have been deprecated since the introduction of ARM and [will be retired soon](https://azure.microsoft.com/en-us/updates/cloud-services-retirement-announcement/). We therefore prevent using these resources for new projects.|
|[${module.policy_root.policy_assignments["Deny-Resource-Locations"].display_name}](https://www.azadvertizer.net/azpolicyadvertizer/e56962a6-4747-49cd-b67b-bf8b01975c4c.html)|Deny|${module.policy_root.policy_assignments["Deny-Resource-Locations"].description}|We explicitly restrict allowed **resource** locations to EU-locations. Only the following locations are allowed<br>${join("<br>", formatlist("- `%s`", module.policy_root.policy_assignments["Deny-Resource-Locations"].parameters.listOfAllowedLocations.value))}|
|[${module.policy_root.policy_assignments["Deny-RSG-Locations"].display_name}](https://www.azadvertizer.net/azpolicyadvertizer/e765b5de-1225-4ba3-bd56-1ac6695af988.html)|Deny|${module.policy_root.policy_assignments["Deny-RSG-Locations"].description}|We explicitly restrict allowed locations for deploying **resource groups** to EU-locations. Only the following locations are allowed<br>${join("<br>", formatlist("- `%s`", module.policy_root.policy_assignments["Deny-Resource-Locations"].parameters.listOfAllowedLocations.value))}|

### Resource Configuration Policies

These policies help ensure Azure resources are deployed in secure configurations.

> Note: The cloud foundation team cannot possibly assess, recommend and enforce best practice configurations for every
> Azure resource. In alignment with our [shared responsibility](../../README.md) we deploy and enforce these policies
> on a "best effort" basis to address cross-cutting security concerns and well-known security issues.

> 🚧 TODO: customize deployed policies and rationales to your organization's individual needs

|Policy|Effect|Description|Rationale|
|-|-|-|-|
|[${module.policy_root.policy_assignments["Deny-Subnet-Without-Nsg"].display_name}](https://www.azadvertizer.net/azpolicyadvertizer/Deny-Subnet-Without-Nsg.html)|Deny|${module.policy_root.policy_assignments["Deny-Subnet-Without-Nsg"].description}|We do allow creation of custom subnets in some landing zones. Requiring explicit configuration of NSGs ensures application teams take explicit responsibility for securing subnet traffic.|
|[${module.policy_root.policy_assignments["Audit-Resource-Locations"].display_name}](https://www.azadvertizer.net/azpolicyadvertizer/0a914e76-4921-4c19-b460-a2d36003525a.html)|Audit|${module.policy_root.policy_assignments["Audit-Resource-Locations"].description}|Diverging resource group and resource locations can create unintended availability risks for deploying and updating resources in case of outages of the resource group location. We monitor and surface this to application teams to make sure they are consciously considering this risk.|
|[${module.policy_root.policy_assignments["Enforce-GR-KeyVault"].display_name}](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Guardrails-KeyVault.html)|Deny, Audit|${module.policy_root.policy_assignments["Enforce-GR-KeyVault"].description}|KeyVaults are critical infrastructure component for secret management used for applications and a variety of Azure Services. Centrally enforcing best-practices guardrails helps us maintain a better security posture for managing secrets.|
|[${module.policy_root.policy_assignments["Enforce-TLS-SSL"].display_name}](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-EncryptTransit.html)|Deny, Audit, DeployIfNotExists, Append|${module.policy_root.policy_assignments["Enforce-TLS-SSL"].description}|Many Azure Services like App Services or Azure Database support minimum required TLS and SSL versions. This policy allows us to monitor compliance to our organization's crypto policies.|


## Application Landing Zones

We separate landing zones for applications into two different types based on their network connectivity model.
Application teams have to choose up front wether they to connect their networks to on-premise or the public internet.
This decision significantly simplifies securing workloads and ensuring a good security both.
Mixing both connectivity models is therefore not possible

### Online Landing Zones

No special restrictions apply.

> 🚧 TODO: In advanced stages of your cloud journey you may consider deploying centrally managed WAFs and internet egress solutions.

### On-Premise Landing Zones

> 🚧 TODO: to deploy on-premise connectivity, have a look at the separate kit modules on collie hub provided for this purpose and link it here.

::: tip
In the on-premises connectivity model you can typically indirectly connect to the internet via existing infrastructure like proxies or gateways.
:::

## Platform Landing Zones

The platform-level management group is further subdivided into the following management groups.
This subdivision does currently not affect any policies and is merely used for access control inside the cloud foundation team.

```md
`${resource.azurerm_management_group.parent.display_name}` this is the root of the hierarchy
└── `${resource.azurerm_management_group.platform.display_name}` platform-level workloads, restriced access only for cloud foundation team
   ├── `${resource.azurerm_management_group.connectivity.display_name}` connectivity solutions like on-prem connection network hub
   ├── `${resource.azurerm_management_group.identity.display_name}` identity management solutions
   └── `${resource.azurerm_management_group.management.display_name}` platform management solutions for deploying our cloud foundation
```

EOF
}
