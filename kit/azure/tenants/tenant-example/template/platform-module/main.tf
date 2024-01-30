module "subscription" {
  source = "../../../../../../../../../kit/azure/tenants/subscription"

  subscription_name       = "NAME-YOUR-SUBSCRIPTION"
  parent_management_group = "NAME-OF-THE-LANDINGZONE"
}
