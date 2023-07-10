variable "output_md_file" {
  type        = string
  description = "location of the file where this cloud foundation kit module generates its documentation output"
}

resource "local_file" "output_md" {
  filename = var.output_md_file
  content  = <<EOF
This landing zone is intended for workloads that do not need internet connectivity.

### Active Policies

- **${data.azurerm_policy_definition.allowed_vm_skus.display_name}**: ${data.azurerm_policy_definition.allowed_vm_skus.description}

EOF
}
