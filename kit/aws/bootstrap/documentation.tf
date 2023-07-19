output "documentation_md" {
  value = <<EOF
This platform is bootstrapped in the AWS Root Account with number `${var.aws_root_account_id}`.

### Deployment Automation

The AWS IAM user deploying this cloudfoundation is `${var.iam_user_name}`.
The credential is stored in terraform state and made available as an output.
EOF
}
