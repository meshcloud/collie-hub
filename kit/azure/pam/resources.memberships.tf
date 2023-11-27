# NOTE: if you don't want to manage group membership via terraform, you can simply remove this whole file
# NOTE: this membership management does not prevent side-administration, e.g. you can still have more members in these groups
#  managed outside of terraform
# 
# USAGE: Your will need to run terraform apply 2x in order to create a new membership and make it appear in the output.
#  There are workarounds to this but they push # a lot of additional complexity into an already complex terraform module.
#   For production use, cloud foundation teams should strongly consider not managing group membership via this module
#  anyway and only let it generate documentation.

# fetch desired members for all groups
data "azuread_group" "pam_desired_groups" {
  for_each = toset([for g in var.pam_group_members: g.group_object_id])

  object_id = each.key
  security_enabled = true
}

# fetch desired members for all groups
data "azuread_user" "pam_desired_users" {
  for_each = toset(flatten([for g in var.pam_group_members : g.members_by_mail ]))

  mail = each.key
}

locals {  
  memberships = merge(
    [
      for g in var.pam_group_members: {
        # we format entries with a "human readable key" so that they render nicely in terraform plan diffs
        for m in g.members_by_mail: "${data.azuread_group.pam_desired_groups[g.group_object_id].display_name}->${m}" => {
          group = g.group_object_id, 
          member = data.azuread_user.pam_desired_users[m].object_id
        }
      }
    ]...
  )
}

resource "azuread_group_member" "pam_desired_memberships" {
  for_each         = local.memberships
  group_object_id  = each.value.group
  member_object_id = each.value.member
}
