resource "azurerm_management_group" "internal_access" {
  name                       = "internal_access"
  parent_management_group_id = var.parent_management_group_id
}

locals {
  builtin_azurerm_policy_definition_names = {
    no_public_ips = "83a86a26-fd1f-447c-b59d-e51f44264114"
  }
}

data "azurerm_policy_definition" "no_public_ips" {
  name = local.builtin_azurerm_policy_definition_names.no_public_ips
}

resource "azurerm_management_group_policy_assignment" "no_public_ips" {
  name                 = "no public IPs"
  description          = data.azurerm_policy_definition.no_public_ips.description
  policy_definition_id = data.azurerm_policy_definition.no_public_ips.id
  management_group_id  = azurerm_management_group.internal_access.id
}
