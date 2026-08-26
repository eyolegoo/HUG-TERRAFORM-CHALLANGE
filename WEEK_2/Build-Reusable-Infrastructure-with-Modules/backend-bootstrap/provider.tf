terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # This bootstrap config intentionally has NO remote backend of its own —
  # it creates the S3 bucket and DynamoDB table that the main project's
  # backend will point to. Its own state can safely stay local, since it's
  # only ever run once (or rarely) to set up the backend infrastructure.
}

provider "aws" {
  region = var.aws_region
}
