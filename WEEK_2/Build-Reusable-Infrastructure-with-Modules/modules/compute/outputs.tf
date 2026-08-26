output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "ami_id" {
  description = "AMI ID used to launch the instance"
  value       = data.aws_ami.amazon_linux.id
}
