variable "project_name" {
  description = "Project name used to name the state bucket and lock table"
  type        = string
  default     = "two-tier-app"
}

variable "aws_region" {
  description = "AWS region for the state bucket and lock table"
  type        = string
  default     = "us-east-1"
}
