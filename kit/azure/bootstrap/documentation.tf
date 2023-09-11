output "documentation_md" {
  value = <<EOF

# Deployment Automation

We are using an Azure Service Principal to deploy all cloudfoundation infrastructure.
The service principal is named `${var.service_principal_name}`.

%{if var.terraform_state_storage != null}
## Terraform State Management

Terraform state for the cloud foundation repository is stored in an Azure Blob Storage Container.
This container is located in the subscription `${data.azurerm_subscription.current.display_name}`.

Access to terraform state is restricted to members of the `${azuread_group.platform_engineers.display_name}` group.
%{endif}

## Platform Engineer Access Management

The `${azuread_group.platform_engineers.display_name}` group is used to grant privileged access to members of the
cloud foundation team. The group has the following members: 

${join("\n", formatlist("- %s", var.platform_engineers_members[*].email))}

EOF
}
