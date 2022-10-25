data "azuread_users" "platform_engineers_members" {
  # unfortunately mail_nicknames attribute does not work on our AADs because we don't sync from on-premise
  # so we have to use user prinicpal names for lookups
  user_principal_names = var.platform_engineers_members
}

resource "azuread_group" "platform_engineers" {
  display_name     = "${var.foundation_name}-cloudfoundation-platform-engineers"
  owners           = [azuread_service_principal.cloudfoundation_deploy.object_id]
  security_enabled = true

  members = toset(data.azuread_users.platform_engineers_members.object_ids)
}
