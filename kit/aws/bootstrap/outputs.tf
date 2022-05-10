output "aws_root_account_id" {
  value       = var.aws_root_account_id
  description = "The id of your AWS Organization's root account"
}

output "cloudfoundation_tf_deploy_user_iam_access_key_id" {
  value = module.cloudfoundation_tf_deploy_user.iam_access_key_id
}

output "cloudfoundation_tf_deploy_user_iam_access_key_secret" {
  value     = module.cloudfoundation_tf_deploy_user.iam_access_key_secret
  sensitive = true
}

output "aws_shared_credentials_file_content" {
  value     = local_file.aws_shared_credentials_file.content
  sensitive = true
}
