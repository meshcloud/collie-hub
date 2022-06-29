variable "output_md_file" {
  type        = string
  description = "location of the file where this cloud foundation kit module generates its documentation output"
}

resource "local_file" "output_md" {
  filename = var.output_md_file
  content  = <<EOF
This platform is bootstrapped in the AWS Root Account with number `${var.aws_root_account_id}`.

### Deployment Automation

The AWS IAM user deploying this cloudfoundation is `${var.iam_user_name}`.
The credential is stored in terraform state and made available as an output.
EOF
}
