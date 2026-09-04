variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to create security groups in"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your public IP address in CIDR notation (e.g. 203.0.113.5/32), used to restrict SSH access"
  type        = string
}

variable "db_port" {
  description = "Port the database listens on"
  type        = number
  default     = 3306
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
