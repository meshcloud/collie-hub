output "documentation_md" {
  value = <<EOF

# 🚢 Container Platform Landing Zone

A Container Platform Landing Zone is a pre-configured infrastructure setup designed to support the deployment of containerized serverless applications. This landing zone is designed to provide a secure and compliant environment for running containerized workloads on Azure Kubernetes Service (AKS). 🚀

## 📂 Management Group Structure

```md
`${resource.azurerm_management_group.container_platform.display_name}` management group for cloud-native landing zone 🚢 
  ├── `${resource.azurerm_management_group.dev.display_name}` management group for development workloads 🛠️
  │  └── *application team subscriptions* 📚
  └── `${resource.azurerm_management_group.prod.display_name}` management group for production workloads 🏭
     └── *application team subscriptions* 📚
```

## 🛡️ Active Policies

|Policy|Effect|Description|Rationale|
|-|-|-|-|
|${module.policy_container_platform.policy_assignments["K8S-Security-Baseline"].display_name}|Audit|${module.policy_container_platform.policy_assignments["K8S-Security-Baseline"].description}|This initiative enforces several security best practices for Kubernetes pods, such as running containers as a non-root user and not allowing privilege escalation. These practices help to minimize the attack surface of your Kubernetes workloads and protect against common security threats.|

## 📚 References

- [CFMM container-platform-landing-zone](https://cloudfoundation.org/maturity-model/tenant-management/container-platform-landing-zone.html)
- [Policy Set K8S-Security-Baseline](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/a8640138-9b0a-4a28-b8cb-1666c838647d.html)

EOF
}
