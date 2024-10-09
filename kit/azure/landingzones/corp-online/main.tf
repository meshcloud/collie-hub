
resource "azurerm_management_group" "corp" {
  display_name               = var.corp
  parent_management_group_id = var.parent_management_group_id
}

resource "azurerm_management_group" "prod" {
  display_name               = "${var.corp}-prod"
  parent_management_group_id = azurerm_management_group.corp.id
}

resource "azurerm_management_group" "dev" {
  display_name               = "${var.corp}-dev"
  parent_management_group_id = azurerm_management_group.corp.id
}

resource "azurerm_management_group" "online" {
  display_name               = var.online
  parent_management_group_id = var.parent_management_group_id
}

module "policy_corp" {
  source = "github.com/meshcloud/collie-hub//kit/azure/util/azure-policies?ref=ef06c8d"

  policy_path         = "${path.module}/lib/corp"
  management_group_id = azurerm_management_group.corp.id
  location            = var.location

  template_file_variables = {
    default_location          = var.location
    connectivity_location     = var.location
    current_scope_resource_id = azurerm_management_group.corp.id
    root_scope_resource_id    = azurerm_management_group.corp.id
    vnet_address_space_id     = var.vnet_address_space_id
    private_dns_zone_prefix   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/${var.cloudfoundation}/dns/providers/Microsoft.Network/privateDnsZones/"
  }
}

module "policy_online" {
  source = "github.com/meshcloud/collie-hub//kit/azure/util/azure-policies?ref=ef06c8d"

  policy_path         = "${path.module}/lib/online"
  management_group_id = azurerm_management_group.online.id
  location            = var.location

  template_file_variables = {
    default_location          = var.location
    current_scope_resource_id = azurerm_management_group.online.id
    root_scope_resource_id    = azurerm_management_group.online.id
  }
}
