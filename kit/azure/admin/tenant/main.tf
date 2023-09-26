module "billing_admins" {
  source        = "./billing-admins"
  aad_tenant_id = var.aad_tenant_id
  billing_users = var.billing_users
}

data "azurerm_management_group" "root" {
  name = var.aad_tenant_id
}
