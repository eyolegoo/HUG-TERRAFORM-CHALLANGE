output "vpc_id" {
  description = "ID of the custom VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.networking.public_subnet_id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.networking.internet_gateway_id
}

output "security_group_id" {
  description = "ID of the Security Group"
  value       = module.security.security_group_id
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.compute.instance_id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.compute.public_ip
}

output "website_url" {
  description = "URL to view the deployed web page"
  value       = "http://${module.compute.public_ip}"
}
