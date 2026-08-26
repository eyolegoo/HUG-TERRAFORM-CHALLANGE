variable "project_name" {
  description = "Name prefix used to tag resources"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to launch the instance into"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group to attach to the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair for SSH access. Leave empty to skip attaching a key pair."
  type        = string
  default     = ""
}

variable "full_name" {
  description = "Full name to display on the web page"
  type        = string
}

variable "event_name" {
  description = "Event name to display on the web page"
  type        = string
}
