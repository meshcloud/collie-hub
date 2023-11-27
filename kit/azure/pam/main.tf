data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}
 
# We have to do some pre-processing here in order to produce nice documentation.

# fetch data about all actual PAM groups
data "azuread_group" "pam_groups" {
  for_each = toset(var.pam_group_object_ids)

  object_id = each.key
  security_enabled = true
}

# fetch the actual members of those groups
data "azuread_user" "pam_users" {
  for_each = toset(flatten([ for g in data.azuread_group.pam_groups : g.members ]))
  
  object_id = each.key
}

locals {
  #  build map of of member object_ids to a "readable" format, e.g. using the mail attribute
  groups = [
    for g in data.azuread_group.pam_groups : {
      display_name = g.display_name
      description = g.description
      members = [for m in g.members: data.azuread_user.pam_users[m].mail]
    }
  ]
}