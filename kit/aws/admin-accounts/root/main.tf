# it's currently not possible to set up AWS SSO through terraform
# nonethteless we capture the results of it as a data object here
data "aws_ssoadmin_instances" "sso" {}

locals {
  aws_sso_instance_arn = tolist(data.aws_ssoadmin_instances.sso.arns)[0] // note: we just assume ther's only one SSO instance in the account
}

module "billing_admins" {
  source = ".//modules/billing-admins/"

  aws_region           = var.aws_region
  aws_root_account_id  = var.aws_root_account_id
  aws_sso_instance_arn = local.aws_sso_instance_arn
  billing_users        = var.billing_users
}

module "organization_policies" {
  source = ".//modules/organization-policies"
}
