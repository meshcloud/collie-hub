resource "btp_subaccount" "subaccount" {
  name      = "sa-${var.workspace}-${var.project}"
  subdomain = "sd-${var.workspace}-${var.project}"
  region    = var.region
}
