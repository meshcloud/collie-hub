output "documentation_md" {
  value = <<EOF
# Lift & Shift Landing Zone

A lift & shift landing zone is a pre-configured environment tailored for migrating existing workloads to the cloud.

Here, an existing subscription serves as the landing zone where the migrated workloads will be deployed using Azure resource groups.

- **Subscription Name**: ${var.lift_and_shift_subscription_name}
- **Subscription ID**: ${data.azurerm_subscription.current.id}

EOF
}
