variable "output_md_file" {
  type        = string
  description = "location of the file where this cloud foundation kit module generates its documentation output"
}

resource "local_file" "output_md" {
  filename = var.output_md_file
  content = <<EOF
### Cloudfoundation Service Principal

The Azure service principal deploying the `${var.foundation_name}` cloudfoundation is named `${var.service_principal_name}`.
The credentials are stored in terraform state.

### Cloudfoundation Terraform State

The storage account name created that will hold the terraform state is named `${var.storage_account_name}`.

EOF
}
