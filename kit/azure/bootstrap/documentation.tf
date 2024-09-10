output "documentation_md" {
  value = <<EOF

# 🌐 Cloud Foundation Deployment

%{if var.terraform_state_storage != null}
## 🔒 Terraform State Management

Terraform state for the cloud foundation repository is stored in an Azure Blob Storage Container. 🗄️
This container is located in the subscription `${data.azurerm_subscription.current.display_name}`. 🎫
Resource Group: `${module.terraform_state.resource_group_name}` 📁

Access to terraform state is restricted to members of the `${azuread_group.platform_engineers.display_name}` group. 👥

%{endif}

%{if var.documentation_uami != null || var.validation_uami != null}
## 🤖 Automation

%{if var.documentation_uami != null}
The UAMI `${azurerm_user_assigned_identity.docs[0].name}` has been set up for the automated creation of
landing zone documentation via a GitHub actions pipeline. This UAMI has read-only access to terraform state. 📚
%{endif}

%{if var.validation_uami != null}
The UAMI `${azurerm_user_assigned_identity.validation[0].name}` has been set up for the automated validation a GitHub actions pipeline.
This UAMI has read-only access to terraform state and read only access to the entire landing zone architecture. 🏗️
%{endif}
%{endif}

## 👨‍💻 Platform Engineer Access Management

The `${azuread_group.platform_engineers.display_name}` group is used to grant privileged access to members of the
cloud foundation team. The group has the following members:

${join("\n", formatlist("- %s", var.platform_engineers_members[*].email))}

|permissions|
|-|
${join("\n", formatlist("| %s |", azurerm_role_definition.cloudfoundation_deploy.permissions[0].actions))}

EOF
}
