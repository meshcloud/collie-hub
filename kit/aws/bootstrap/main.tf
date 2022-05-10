# Key configuration of the organization root account
module "cloudfoundation_tf_deploy_user" {
  source                 = "../util/iam-user"
  iam_user_name          = var.iam_user_name
  iam_policy_description = "Permissions required to deploy the cloudfoundation (not operate it)"
  iam_policy_policy      = file(".//cfn-tf-deploy.policy.json")
}

resource "local_file" "aws_shared_credentials_file" {
  filename        = var.aws_shared_credentials_file
  file_permission = "600" # only current user can read/write
  content         = <<EOF
[default]
aws_access_key_id = ${module.cloudfoundation_tf_deploy_user.iam_access_key_id}
aws_secret_access_key = ${module.cloudfoundation_tf_deploy_user.iam_access_key_secret}
EOF
}
