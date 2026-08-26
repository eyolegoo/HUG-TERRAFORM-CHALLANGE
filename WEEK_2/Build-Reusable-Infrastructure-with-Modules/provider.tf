terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # -----------------------------------------------------------------
  # Remote backend: Terraform state is stored in S3, locked via DynamoDB.
  #
  # This is a PARTIAL configuration on purpose — backend blocks cannot
  # reference variables, so the bucket/table/region are supplied at
  # `terraform init` time via backend.hcl (see backend.hcl.example).
  #
  # Run:
  #   terraform init -backend-config="backend.hcl"
  # -----------------------------------------------------------------
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}
