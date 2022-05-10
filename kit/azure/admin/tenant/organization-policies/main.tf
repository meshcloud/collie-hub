/*
We need to get the management group itself to pass to the policy resource because we won't have the right id.

We have to do this in direct contradiction to the docs:
> if you are using azurerm_management_group to assign a value to management_group_id, be sure to use name or group_id attribute, but not id.

See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition#management_group_id

// todo: raise an issue on github about this...
*/

data "azurerm_management_group" "root" {
  name = var.aad_tenant_id // can be a name or UUID
}


module "policy_allowed_locations" {
  source                     = "../../../util/azure-policy"
  policy_json_file           = "${path.module}/allowed-locations.policy.json"
  policy_name                = "allowed locations"
  policy_management_group_id = data.azurerm_management_group.root.id
}


resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  name                 = "allowed locations"
  policy_definition_id = module.policy_allowed_locations.policy.id
  management_group_id  = data.azurerm_management_group.root.id
  parameters = jsonencode({
    listOfAllowedLocations = {
      value = var.allowed_locations
    }
  })
}
