output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets (used for internet-facing EKS load balancers)"
  value       = aws_subnet.public[*].id
}

output "public_subnet_tags" {
  description = "The tags of the public subnets (EKS-related)"
  value       = { for subnet in aws_subnet.public : subnet.id => subnet.tags }
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets (used for internal-facing EKS load balancers)"
  value       = aws_subnet.private[*].id
}

output "private_subnet_tags" {
  description = "The tags of the private subnets (EKS-related)"
  value       = { for subnet in aws_subnet.private : subnet.id => subnet.tags }
}

output "attach_subnet_ids" {
  description = "The IDs of the attach subnets (general-purpose subnets)"
  value       = aws_subnet.attach[*].id
}

output "attach_subnet_tags" {
  description = "The tags of the attach subnets"
  value       = { for subnet in aws_subnet.attach : subnet.id => subnet.tags }
}