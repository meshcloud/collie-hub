terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.37.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}

provider "stackit" {
  region                = "eu01"
  service_account_token = var.token
}

#TODO: we are using AWS as our Terraform backend. Its up to you where your TF state will hosted.
terraform {
  backend "s3" {
    bucket = "buildingblocks-tfstates-p32kj" # Must match what's configured in automation backend
    key    = "terraform/stackit-project"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-central-1"

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/LikvidBuildingBlockServiceRole" # Must match what's configured in automation backend
  }
}
