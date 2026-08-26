variable "aws_region" {
  description = "AWS region for the backend resources"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "Globally-unique name for the S3 bucket that will store Terraform state. Bucket names are global across all AWS accounts, so pick something specific (e.g. include your name or a random suffix)."
  type        = string
}

variable "lock_table_name" {
  description = "Name of the DynamoDB table used for Terraform state locking"
  type        = string
  default     = "hug-terraform-locks"
}
