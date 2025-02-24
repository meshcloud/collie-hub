data "azurerm_subscription" "current" {
}

resource "azuread_application" "bb_postgresql" {
  display_name = "bb-postgresql"
}

resource "azuread_service_principal" "bb_postgresql" {
  client_id = azuread_application.bb_postgresql.client_id
}

resource "azuread_service_principal_password" "bb_postgresql" {
  service_principal_id = azuread_service_principal.bb_postgresql.id
}

resource "azurerm_role_assignment" "bb_postgresql" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor" # TODO: restrict permissions
  principal_id         = azuread_service_principal.bb_postgresql.object_id
}

resource "azurerm_role_assignment" "terraform_state" {
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_service_principal.bb_postgresql.object_id
  scope                = var.tfstates_resource_manager_id
}

resource "azurerm_resource_group" "bb_postgresql" {
  name     = "bb-postgresql"
  location = "Germany West Central"
}

data "azurerm_virtual_network" "aks" {
  name                = "aks-vnet-17585647"
  resource_group_name = "MC_aks-rg_aks_germanywestcentral"
}

resource "azurerm_subnet" "bb_postgresql" {
  name                 = "postgresql-subnet"
  resource_group_name  = data.azurerm_virtual_network.aks.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.aks.name

  address_prefixes = ["10.226.0.0/16"]

  service_endpoints = [
    "Microsoft.Storage",
  ]

  delegation {
    name = "delegation"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "bb_postgresql" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.bb_postgresql.name

}
resource "azurerm_private_dns_zone_virtual_network_link" "bb_postgresql" {
  name                  = "bb-postgresql"
  resource_group_name   = azurerm_resource_group.bb_postgresql.name
  private_dns_zone_name = azurerm_private_dns_zone.bb_postgresql.name
  virtual_network_id    = data.azurerm_virtual_network.aks.id
}

