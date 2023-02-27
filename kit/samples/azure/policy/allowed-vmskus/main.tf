locals {
  builtin_azurerm_policy_definition_names = {
    allowed_vm_skus                 = "cccc23c7-8427-4f53-ad12-b6a63eb452b3"
  }
}

data "azurerm_policy_definition" "allowed_vm_skus" {
  name = local.builtin_azurerm_policy_definition_names.allowed_vm_skus
}

data "azurerm_client_config" "current" { 
}

# Assign Allowed_VM_SKUs Policy
resource "azurerm_management_group_policy_assignment" "allowed_vm_skus" {
  name                 = "allowed-vm-skus"
  management_group_id  = data.azurerm_management_group.admin.id 
  policy_definition_id = data.azurerm_policy_definition.allowed_vm_skus.id
  description          = data.azurerm_policy_definition.allowed_vm_skus.description
  display_name         = data.azurerm_policy_definition.allowed_vm_skus.display_name

  parameters = jsonencode({
    listOfAllowedSKUs = {
      value = [var.listofallowedvmskus] 
    }
  })
}