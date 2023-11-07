data "azuread_users" "platform_engineers_members" {
  # unfortunately mail_nicknames attribute does not work on our AADs because we don't sync from on-premise
  # so we have to use user prinicpal names for lookups
  user_principal_names = var.platform_engineers_members[*].upn
}

resource "azuread_group" "platform_engineers" {
  display_name     = var.platform_engineers_group
  owners           = [data.azuread_client_config.current.object_id] # todo: possibly the owner needs to be the cloudfoundation SPN? need to figure out dependency order inside the boostrap module!
  security_enabled = true

  members = toset(data.azuread_users.platform_engineers_members.object_ids)
}
