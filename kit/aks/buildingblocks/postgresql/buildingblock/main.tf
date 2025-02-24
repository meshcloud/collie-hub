resource "random_password" "administrator_password" {
  length      = 24
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  special     = false
}

resource "azurerm_postgresql_flexible_server" "db_instance" {
  name                = "${var.workspace_identifier}-${var.project_identifier}-${var.name}"
  resource_group_name = local.resource_group_name
  location            = local.location

  delegated_subnet_id           = local.subnet_id
  private_dns_zone_id           = local.private_dns_zone_id
  public_network_access_enabled = false

  create_mode            = "Default"
  version                = "16"
  administrator_login    = "psqladmin"
  administrator_password = random_password.administrator_password.result

  storage_mb   = 32768
  storage_tier = "P4"
  sku_name     = "B_Standard_B1ms"

  lifecycle {
    ignore_changes = [zone]
  }
}

resource "kubernetes_secret" "credentials" {
  metadata {
    namespace = var.namespace
    name      = "postgresql-${var.name}"
  }

  type = "Opaque"
  data = {
    PGHOST     = azurerm_postgresql_flexible_server.db_instance.fqdn
    PGUSER     = "psqladmin"
    PGPORT     = "5432"
    PGDATABASE = "postgres"
    PGPASSWORD = random_password.administrator_password.result
  }
}

output "secret_name" {
  value = kubernetes_secret.credentials.metadata[0].name
}
