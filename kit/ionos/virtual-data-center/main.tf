locals {
  admins  = { for user in var.users : user.username => user if contains(user["roles"], "admin") }
  editors = { for user in var.users : user.username => user if contains(user["roles"], "user") }
  readers = { for user in var.users : user.username => user if contains(user["roles"], "reader") }
}

data "ionoscloud_user" "admins" {
  for_each = local.admins
  email    = each.value.username
}

data "ionoscloud_user" "editors" {
  for_each = local.editors
  email    = each.value.username
}

data "ionoscloud_user" "readers" {
  for_each = local.readers
  email    = each.value.username
}

resource "ionoscloud_datacenter" "this" {
  name                = "${var.workspace_id}-${var.project_id}"
  location            = var.dc_location
  description         = var.dc_description
  sec_auth_protection = false
}

resource "ionoscloud_share" "admin" {
  count           = length(local.admins) > 0 ? 1 : 0
  group_id        = ionoscloud_group.admin[0].id
  resource_id     = ionoscloud_datacenter.this.id
  edit_privilege  = true
  share_privilege = false
}

resource "ionoscloud_share" "editor" {
  count           = length(local.editors) > 0 ? 1 : 0
  group_id        = ionoscloud_group.editor[0].id
  resource_id     = ionoscloud_datacenter.this.id
  edit_privilege  = true
  share_privilege = false

  # workaround to create shares sequentially. See https://github.com/ionos-cloud/terraform-provider-ionoscloud/issues/489
  depends_on = [ionoscloud_share.admin]
}

resource "ionoscloud_share" "reader" {
  count           = length(local.readers) > 0 ? 1 : 0
  group_id        = ionoscloud_group.reader[0].id
  resource_id     = ionoscloud_datacenter.this.id
  edit_privilege  = true
  share_privilege = false

  # workaround to create shares sequentially. See https://github.com/ionos-cloud/terraform-provider-ionoscloud/issues/489
  depends_on = [ionoscloud_share.admin, ionoscloud_share.editor]
}

resource "ionoscloud_group" "admin" {
  count                          = length(local.admins) > 0 ? 1 : 0
  name                           = "${var.workspace_id}-${var.project_id}-admins"
  user_ids                       = [for d in data.ionoscloud_user.admins : d["id"]]
  create_snapshot                = true
  reserve_ip                     = true
  create_pcc                     = true
  s3_privilege                   = true
  create_backup_unit             = true
  create_internet_access         = true
  create_k8s_cluster             = true
  create_flow_log                = true
  access_and_manage_monitoring   = true
  access_and_manage_certificates = true
  manage_dbaas                   = true
}

resource "ionoscloud_group" "editor" {
  count                          = length(local.editors) > 0 ? 1 : 0
  name                           = "${var.workspace_id}-${var.project_id}-editors"
  user_ids                       = [for d in data.ionoscloud_user.editors : d["id"]]
  reserve_ip                     = true
  s3_privilege                   = true
  access_and_manage_monitoring   = true
  access_and_manage_certificates = true
  manage_dbaas                   = true
}

resource "ionoscloud_group" "reader" {
  count    = length(local.readers) > 0 ? 1 : 0
  name     = "${var.workspace_id}-${var.project_id}-readers"
  user_ids = [for d in data.ionoscloud_user.readers : d["id"]]
}
