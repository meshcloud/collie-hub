locals {
  processed_users = merge(
    { for user in var.platform_admins : user.email => merge(user, { login = split("@", user.email)[0] }) }
  )
}
resource "random_password" "user_passwords" {
  for_each         = local.processed_users
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-_=+[]{}<>?/"
}

resource "ovh_me_identity_user" "platform_users" {
  for_each    = local.processed_users
  description = "likvid ovh platform users"
  email       = each.value.email
  group       = "ADMIN"
  login       = "${each.value.login}-admin"
  password    = random_password.user_passwords[each.key].result
}
