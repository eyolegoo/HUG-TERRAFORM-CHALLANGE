variable "project_name" {
  description = "Name prefix used to tag resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to attach networking resources to"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the public subnet"
  type        = string
}
