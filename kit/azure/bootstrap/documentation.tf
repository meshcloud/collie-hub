variable "documentation_md" {
  type     = string
  content  = <<EOF
The Azure Service Principal deploying this cloudfoundation is named `${var.service_principal_name}`.
The credentials are stored in terraform state.
EOF
}