output "documentation_md" {
  value = <<EOF
This landing zone is intended for workloads that do not need internet connectivity.

### Active Policies

- **${data.azurerm_policy_definition.allowed_vm_skus.display_name}**: ${data.azurerm_policy_definition.allowed_vm_skus.description}

EOF
}
