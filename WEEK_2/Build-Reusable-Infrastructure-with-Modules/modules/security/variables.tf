variable "project_name" {
  description = "Name prefix used to tag resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to attach the security group to"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into instances using this security group"
  type        = string
}
