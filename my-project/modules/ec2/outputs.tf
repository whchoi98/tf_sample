# Output: EC2 Instance IDs
output "instance_ids" {
  description = "IDs of all EC2 instances"
  value       = concat(
    aws_instance.public_ec2[*].id,
    aws_instance.private_ec2[*].id
  )
}

# Output: EC2 Private IPs
output "private_ips" {
  description = "Private IPs of all EC2 instances"
  value       = concat(
    aws_instance.public_ec2[*].private_ip,
    aws_instance.private_ec2[*].private_ip
  )
}

# Output: EC2 Public IPs
output "public_ips" {
  description = "Public IPs of all Public EC2 instances"
  value       = aws_instance.public_ec2[*].public_ip
}

# Output: EC2 Instance Names
output "instance_names" {
  description = "Names of all EC2 instances"
  value       = concat(
    [for instance in aws_instance.public_ec2 : instance.tags["Name"]],
    [for instance in aws_instance.private_ec2 : instance.tags["Name"]]
  )
}