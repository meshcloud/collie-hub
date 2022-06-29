output "service_account_name" {
  value = google_service_account.cloudfoundation_tf_deploy_user.account_id
}

output "service_account_email" {
  value = google_service_account.cloudfoundation_tf_deploy_user.email
}

output "service_account_credentials" {
  value       = google_service_account_key.cloudfoundation_tf_deploy_user.private_key
  description = "base64 encoded service account credentials file content"
  sensitive   = true
}
