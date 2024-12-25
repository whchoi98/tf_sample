output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.ec2[*].id
}

output "private_ips" {
  description = "Private IPs of the EC2 instances"
  value       = aws_instance.ec2[*].private_ip
}

output "public_ips" {
  description = "Public IPs of the EC2 instances (only for public subnets)"
  value       = aws_instance.ec2[*].public_ip
}

output "instance_names" {
  description = "Name tags of the EC2 instances"
  value       = [for instance in aws_instance.ec2 : instance.tags["Name"]]
}