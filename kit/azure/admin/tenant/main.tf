module "organization_policies" {
  source            = "./organization-policies"
  aad_tenant_id     = var.aad_tenant_id
  allowed_locations = var.allowed_locations
}

module "billing_admins" {
  source        = "./billing-admins"
  aad_tenant_id = var.aad_tenant_id
  billing_users = var.billing_users
}
