terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.65.0"
    }
  }
}

provider "aws" {
  region              = "eu-central-1"
  allowed_account_ids = ["125191384046"]
}

resource "aws_amplify_app" "colliehub" {
  name       = "collie-hub"
  repository = "https://github.com/meshcloud/collie-hub"

  environment_variables = {
    "AMPLIFY_ENV" = "dev"
  }

  custom_rule {
    source = "/<*>"
    status = "404-200"
    target = "/index.html"
  }

  custom_rule {
    source = "/api/event"
    status = "200"
    target = "https://plausible.io/api/event"
  }

  // this is a default redirect set up by amplify
  # custom_rule {
  #   source = "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|ttf|map|json)$)([^.]+$)/>"
  #   status = "200"
  #   target = "/index.html"
  # }
}


resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.colliehub.id
  branch_name = "main"
  framework   = "Web"
  stage       = "PRODUCTION"
  tags        = {}

  enable_pull_request_preview = true

  environment_variables = {
    "AMPLIFY_ENV" = "prod"
  }

}


resource "aws_amplify_domain_association" "collie_cloudfoundation_org" {
  app_id                = aws_amplify_app.colliehub.id
  domain_name           = "collie.cloudfoundation.org"
  wait_for_verification = false

  sub_domain {
    branch_name = aws_amplify_branch.main.branch_name
    prefix      = ""
  }
}

output "domains" {
  value = [
    aws_amplify_domain_association.collie_cloudfoundation_org
  ]
}
