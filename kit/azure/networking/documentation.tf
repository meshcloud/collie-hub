output "documentation_md" {
  value = <<EOF
# Networking

Connection to the hub is the pre-requisite for getting access to th on-prem network.

The hub itself has the following address space `${var.address_space}`.

Upon request, we will peer a VNet in your subscription with the hub.

We currently have assigned

| Application | Range |
|-|-|
| Glaskugel | 10.1.0.0/24 |

Next free entry: 10.1.0.1/24


Access to central Network Hub is granted on need-to-know basis to Auditors and Cloud Foundation Team members.
The following AAD groups control access and are used to implement [Privileged Access Management](./azure-pam.md).

|group|description|
|-|-|
| ${azuread_group.network_admins.display_name} | ${azuread_group.network_admins.description} |

EOF
}
