module "subscription" {
  source = "../../subscription"
  # Use local sources for testing
  #source = "../../../../../../../../../kit/azure/buildingblocks/subscription"

  subscription_name       = "tenant-example"
  parent_management_group = "cloudnative"
}
