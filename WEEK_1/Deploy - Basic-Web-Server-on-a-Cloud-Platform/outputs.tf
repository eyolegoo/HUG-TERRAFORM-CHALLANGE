output "vpc_id" {
  description = "ID of the custom VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "security_group_id" {
  description = "ID of the Security Group"
  value       = aws_security_group.web_sg.id
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "website_url" {
  description = "URL to view the deployed web page"
  value       = "http://${aws_instance.web.public_ip}"
}
