variable "project_name" {
  description = "Name used to prefix and tag all resources"
  type        = string
  default     = "two-tier-app"
}

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "Availability zones to use (needs at least 2, for the RDS subnet group)"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

#############################################
# Networking
#############################################
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}

#############################################
# Security
#############################################
variable "my_ip_cidr" {
  description = "Your public IP in CIDR notation, e.g. 203.0.113.5/32 (used to restrict SSH access)"
  type        = string
}

#############################################
# Compute
#############################################
variable "instance_type" {
  description = "EC2 instance type for the web server"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair for SSH access"
  type        = string
}

#############################################
# Database
#############################################
variable "db_engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage for the database, in GB"
  type        = number
  default     = 20
}

variable "db_port" {
  description = "Port the database listens on"
  type        = number
  default     = 3306
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "db_backup_retention_period" {
  description = "Number of days to retain automated DB backups. Free-tier AWS accounts restrict this — use 0 if you hit a FreeTierRestrictionError."
  type        = number
  default     = 0
}

#############################################
# Tagging
#############################################
variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "two-tier-app"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
