terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "1.5.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}



provider "ovh" {
  endpoint = "ovh-eu"
}

#TODO: we are using AWS as our Terraform backend. Its up to you where your TF state will hosted.
terraform {
  backend "s3" {
    bucket = "buildingblocks-tfstates-p32kj"
    key    = "terraform/ovh-project"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-central-1"

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/LikvidBuildingBlockServiceRole" # Must match what's configured in automation backend
  }
}
