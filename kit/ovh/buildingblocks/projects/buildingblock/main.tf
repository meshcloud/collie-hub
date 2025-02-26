data "ovh_me_identity_users" "users" {}

data "ovh_me_identity_user" "user" {
  for_each = toset(data.ovh_me_identity_users.users.users)
  user     = each.value
}
locals {
  processed_users = {
    for user in var.users : user.email => merge(user, {
      login = split("@", user.email)[0],
      group = "DEFAULT"
    })
  }

  user_urns = {
    for k, v in data.ovh_me_identity_user.user :
    k => v.urn if v.group == "DEFAULT"
  }

  admin_urns = compact([
    for email, user in local.processed_users :
    lookup(local.user_urns, user.login, null)
    if contains(user.roles, "admin")
  ])

  editor_urns = compact([
    for email, user in local.processed_users :
    lookup(local.user_urns, user.login, null)
    if contains(user.roles, "editor")
  ])

  reader_urns = compact([
    for email, user in local.processed_users :
    lookup(local.user_urns, user.login, null)
    if contains(user.roles, "reader")
  ])
}

data "ovh_me" "myaccount" {}

data "ovh_order_cart" "mycart" {
  ovh_subsidiary = data.ovh_me.myaccount.ovh_subsidiary
}

data "ovh_order_cart_product_plan" "cloud" {
  cart_id        = data.ovh_order_cart.mycart.id
  price_capacity = "renew"
  product        = "cloud"
  plan_code      = "project.2018"
}

resource "ovh_cloud_project" "cloud_project" {
  ovh_subsidiary = data.ovh_order_cart.mycart.ovh_subsidiary
  description    = "${var.workspace_id}-${var.project_id}"
  plan {
    duration     = data.ovh_order_cart_product_plan.cloud.selected_price[0].duration
    pricing_mode = data.ovh_order_cart_product_plan.cloud.selected_price[0].pricing_mode
  }
}

resource "ovh_iam_policy" "admin" {
  for_each    = length(local.admin_urns) > 0 ? { "admin" = true } : {}
  name        = "${var.workspace_id}-${var.project_id}-admin"
  description = "Administrator full access policy for ${var.workspace_id}-${var.project_id}"
  identities  = local.admin_urns
  resources   = [ovh_cloud_project.cloud_project.urn]
  allow       = ["publicCloudProject:apiovh:*"]
}

resource "ovh_iam_policy" "editor" {
  for_each    = length(local.editor_urns) > 0 ? { "editor" = true } : {}
  name        = "${var.workspace_id}-${var.project_id}-editor"
  description = "Editor access policy for ${var.workspace_id}-${var.project_id}"
  identities  = local.editor_urns
  resources   = [ovh_cloud_project.cloud_project.urn]
  allow = [
    "publicCloudProject:apiovh:containerRegistry/*",
    "publicCloudProject:apiovh:dataProcessing/notebooks/*",
    "publicCloudProject:apiovh:dataProcessing/jobs/*",
    "publicCloudProject:apiovh:rancher/*",
    "publicCloudProject:apiovh:kubernetes/*",
    "publicCloudProject:apiovh:instance/*",
    "publicCloudProject:apiovh:storage/*"
  ]
}

resource "ovh_iam_policy" "reader" {
  for_each    = length(local.reader_urns) > 0 ? { "reader" = true } : {}
  name        = "${var.workspace_id}-${var.project_id}-reader"
  description = "Reader access policy for ${var.workspace_id}-${var.project_id}"
  identities  = local.reader_urns
  resources   = [ovh_cloud_project.cloud_project.urn]
  allow = [
    "publicCloudProject:apiovh:containerRegistry/get",
    "publicCloudProject:apiovh:dataProcessing/notebooks/get",
    "publicCloudProject:apiovh:dataProcessing/jobs/get",
    "publicCloudProject:apiovh:rancher/get",
    "publicCloudProject:apiovh:kube/get",
    "publicCloudProject:apiovh:instance/get",
    "publicCloudProject:apiovh:storage/get"
  ]
}
