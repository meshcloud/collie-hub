output "documentation_md" {
  value = <<EOF
  # tip:
  # pro-tip: you can
  content = <<EOF
The foundation-level resources are deployed to the GCP project with project id `${var.foundation_project_id}`.

### Terraform Service Account

The Service Account user for deploying this cloudfoundation from terraform is
`${google_service_account.cloudfoundation_tf_deploy_user.display_name}`.

Its credentials are stored in terraform state and made available locally after performing the bootstrap.
EOF
}
