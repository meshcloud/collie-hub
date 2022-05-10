variable "output_md_file" {
  type        = string
  description = "location of the file where this cloud foundation kit module generates its documentation output"
}

resource "local_file" "output_md" {
  filename = var.output_md_file
  # tip: 
  # pro-tip: you can 
  content = <<EOF
The foundation-level resources are deployed to the GCP project with project id `${var.foundation_project_id}`.

The Service Account user deploying this cloudfoundation is `${google_service_account.cloudfoundation_tf_deploy_user.display_name}`.
The credential are stored in terraform state and made available locally after performing the bootstrap at `${var.service_account_credentials_file}`.
EOF
}
