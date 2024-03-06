output "documentation_md" {
  value = <<EOF

# Cloud Foundation Deployment

%{if var.terraform_state_storage != null}
## Terraform State Management

Terraform state for the cloud foundation repository is stored in an Azure Blob Storage Container.
This container is located in the subscription `${data.azurerm_subscription.current.display_name}`.

Access to terraform state is restricted to members of the `${azuread_group.platform_engineers.display_name}` group.
%{endif}


%{if var.uami_documentation_spn == true}
## Collie Docs with user-assigned managed identities

the following UAMI `${module.terraform_state[0].uami_documentation_name}` has been set up for the automated creation of
collie docs via a pipeline that has access to the following resource

- `${module.terraform_state[0].container_id}`

%{endif}

## Platform Engineer Access Management

The `${azuread_group.platform_engineers.display_name}` group is used to grant privileged access to members of the
cloud foundation team. The group has the following members:

${join("\n", formatlist("- %s", var.platform_engineers_members[*].email))}

EOF
}
