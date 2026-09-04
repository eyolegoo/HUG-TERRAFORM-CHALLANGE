# Remote state storage.
#
# NOTE: The S3 bucket and DynamoDB lock table referenced here cannot be
# created by this same configuration (a chicken-and-egg problem: Terraform
# needs the backend to exist before it can store state in it). Provision
# them once using the /bootstrap configuration in this repo, then fill in
# the values below before running `terraform init` here.
#
# Example bootstrap outputs:
#   bucket         = "two-tier-app-tfstate-<random-suffix>"
#   dynamodb_table = "two-tier-app-tf-locks"

terraform {
  backend "s3" {
    bucket         = "two-tier-app-tfstate-4821d800"
    key            = "two-tier-app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "two-tier-app-tf-locks"
    encrypt        = true
  }
}
