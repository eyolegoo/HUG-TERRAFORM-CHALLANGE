output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "web_server_public_ip" {
  description = "Public IP of the Nginx web server"
  value       = module.compute.public_ip
}

output "web_server_public_dns" {
  description = "Public DNS of the Nginx web server"
  value       = module.compute.public_dns
}

output "website_url" {
  description = "URL to view the deployed webpage"
  value       = "http://${module.compute.public_ip}"
}

output "db_endpoint" {
  description = "Connection endpoint of the RDS instance (only reachable from inside the VPC)"
  value       = module.database.db_endpoint
}

output "web_security_group_id" {
  description = "ID of the web tier security group"
  value       = module.security.web_sg_id
}

output "db_security_group_id" {
  description = "ID of the database tier security group"
  value       = module.security.db_sg_id
}
