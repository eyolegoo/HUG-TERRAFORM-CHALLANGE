variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix used to tag/name all resources"
  type        = string
  default     = "hug-terraform-challenge"
}

variable "vpc_cidr" {
  description = "CIDR block for the custom VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the public subnet"
  type        = string
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair to enable SSH access. Leave empty to skip attaching a key pair."
  type        = string
  default     = ""
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into the instance. Restrict this to your own IP (e.g.  0.0.0.0/32) instead of leaving it open to the world."
  type        = string
  default     = "0.0.0.0/0"
}

variable "full_name" {
  description = "Your full name (Firstname Lastname) to display on the web page"
  type        = string
  default     = "Firstname Lastname"
}

variable "event_name" {
  description = "Event name to display on the web page"
  type        = string
  default     = "HUG Lagos/Ibadan Terraform Challenge"
}
