# Output: VPC ID / VPC ID
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

# Output: 퍼블릭 서브넷 ID / Public Subnet IDs
output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

# Output: 프라이빗 서브넷 ID / Private Subnet IDs
output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

# Output: Attach 서브넷 ID / Attach Subnet IDs
output "attach_subnet_ids" {
  description = "The IDs of the attach subnets"
  value       = aws_subnet.attach[*].id
}

# Output: DB 서브넷 ID / DB Subnet IDs
output "db_subnet_ids" {
  description = "The IDs of the DB subnets"
  value       = aws_subnet.db[*].id
}

