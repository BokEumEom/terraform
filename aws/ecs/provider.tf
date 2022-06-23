# AWS provider
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  assume_role {
    role_arn = var.assume_role
  }
}

terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "account-terraform-states"
    key            = "ecs/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-lock"
    profile        = "admin"
    role_arn       = "arn:aws:iam::account:role/assume-admin"
  }

  required_providers {
    aws = {
      version = "~> 4.10.0"
    }
  }
}
