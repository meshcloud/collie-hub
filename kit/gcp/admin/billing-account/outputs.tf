output "collie_billing_view_ids" {
  value = module.collie_billing_view[*].view_id
}