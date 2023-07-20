output "documentation_md" {
  value = <<EOF

This documentation is intended as a summary of deployed Management Groups of your Azure Organization Hierarchy

### Parent Management Group
 - ${var.parentManagementGroup}

### ${var.landingzones}
  - ${var.online} ${resource.azurerm_management_group.online.name}
  - ${var.corp} ${resource.azurerm_management_group.corp.name}

### ${var.platform}
  - ${var.identity} ${resource.azurerm_management_group.identity.name}
  - ${var.connectivity} ${resource.azurerm_management_group.connectivity.name}
  - ${var.management} ${resource.azurerm_management_group.management.name}

EOF
}

