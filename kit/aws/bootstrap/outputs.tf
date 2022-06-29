output "aws_root_account_id" {
  value       = var.aws_root_account_id
  description = "The id of your AWS Organization's root account"
}

output "cloudfoundation_tf_deploy_user_iam_access_key_id" {
  value = aws_iam_access_key.key.id
}

output "cloudfoundation_tf_deploy_user_iam_access_key_secret" {
  value     = aws_iam_access_key.key.secret
  sensitive = true
}
