resource "azurerm_management_group" "container_platform" {
  display_name               = var.lz-container-platform
  parent_management_group_id = var.parent_management_group_id
}

resource "azurerm_management_group" "dev" {
  display_name               = "k8s-dev"
  parent_management_group_id = azurerm_management_group.container_platform.id

  lifecycle {
    ignore_changes = [subscription_ids]
  }
}

resource "azurerm_management_group" "prod" {
  display_name               = "k8s-prod"
  parent_management_group_id = azurerm_management_group.container_platform.id

  lifecycle {
    ignore_changes = [subscription_ids]
  }
}

module "policy_container_platform" {
  source = "github.com/meshcloud/collie-hub//kit/azure/util/azure-policies?ref=7c356a7"

  policy_path         = "${path.module}/lib"
  management_group_id = azurerm_management_group.container_platform.id
  location            = var.location

  template_file_variables = {
    default_location          = var.location
    current_scope_resource_id = azurerm_management_group.container_platform.id
  }
}

module "policy_container_platform_dev" {
  source = "github.com/meshcloud/collie-hub//kit/azure/util/azure-policies?ref=7c356a7"

  policy_path         = "${path.module}/lib/dev"
  management_group_id = azurerm_management_group.dev.id
  location            = var.location

  template_file_variables = {
    default_location          = var.location
    current_scope_resource_id = azurerm_management_group.dev.id
    parent_scope_resource_id  = azurerm_management_group.container_platform.id
  }
}

module "policy_container_platform_prod" {
  source = "github.com/meshcloud/collie-hub//kit/azure/util/azure-policies?ref=7c356a7"

  policy_path         = "${path.module}/lib/prod"
  management_group_id = azurerm_management_group.prod.id
  location            = var.location

  template_file_variables = {
    default_location          = var.location
    current_scope_resource_id = azurerm_management_group.prod.id
    parent_scope_resource_id  = azurerm_management_group.container_platform.id
  }
}

