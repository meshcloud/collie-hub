variable "output_md_file" {
  type        = string
  description = "location of the file where this cloud foundation kit module generates its documentation output"
}

resource "local_file" "output_md" {
  filename = var.output_md_file
  content  = <<EOF
The Azure Service Principal deploying this cloudfoundation is named `${var.service_principal_name}`.
The credential are stored in terraform state and made available locally after performing the bootstrap at `${var.service_principal_credentials_file}`.
EOF
}