locals {
  existing_logins = toset(data.ovh_me_identity_users.users.users)
  processed_users = {
    for user in var.users : user.email => merge(user, { login = split("@", user.email)[0], group = "DEFAULT" })
  }

  new_users = {
    for k, v in local.processed_users :
    k => v if !contains(local.existing_logins, v.login)
  }

  existing_users = {
    for k, v in local.processed_users :
    k => v if contains(local.existing_logins, v.login)
  }

  all_users = merge(local.new_users, local.existing_users)

}

data "ovh_me" "myaccount" {}
data "ovh_me_identity_users" "users" {}

data "ovh_order_cart" "mycart" {
  ovh_subsidiary = data.ovh_me.myaccount.ovh_subsidiary
}

data "ovh_order_cart_product_plan" "cloud" {
  cart_id        = data.ovh_order_cart.mycart.id
  price_capacity = "renew"
  product        = "cloud"
  plan_code      = "project.2018"
}

resource "random_password" "user_passwords" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-_=+[]{}<>?/"
}

resource "ovh_me_identity_user" "platform_users" {
  for_each    = local.all_users
  description = "Likvid OVH Platform User"
  email       = each.value.email
  group       = each.value.group
  login       = each.value.login
  password    = random_password.user_passwords.result
}
