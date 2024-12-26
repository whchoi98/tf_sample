# Output: VPC ID / VPC ID
# 생성된 VPC의 ID를 출력합니다.
# Outputs the ID of the created VPC.
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

# Output: 퍼블릭 서브넷 ID / Public Subnet IDs
# 생성된 퍼블릭 서브넷의 ID 목록을 출력합니다.
# Outputs the IDs of the public subnets.
output "public_subnet_ids" {
  description = "The IDs of the public subnets (used for internet-facing EKS load balancers)"
  value       = aws_subnet.public[*].id
}

# Output: 퍼블릭 서브넷 태그 / Public Subnet Tags
# 생성된 퍼블릭 서브넷의 태그를 출력합니다.
# Outputs the tags of the public subnets.
output "public_subnet_tags" {
  description = "The tags of the public subnets (EKS-related)"
  value       = { for subnet in aws_subnet.public : subnet.id => subnet.tags }
}

# Output: 프라이빗 서브넷 ID / Private Subnet IDs
# 생성된 프라이빗 서브넷의 ID 목록을 출력합니다.
# Outputs the IDs of the private subnets.
output "private_subnet_ids" {
  description = "The IDs of the private subnets (used for internal-facing EKS load balancers)"
  value       = aws_subnet.private[*].id
}

# Output: 프라이빗 서브넷 태그 / Private Subnet Tags
# 생성된 프라이빗 서브넷의 태그를 출력합니다.
# Outputs the tags of the private subnets.
output "private_subnet_tags" {
  description = "The tags of the private subnets (EKS-related)"
  value       = { for subnet in aws_subnet.private : subnet.id => subnet.tags }
}

# Output: Attach 서브넷 ID / Attach Subnet IDs
# 생성된 Attach 서브넷의 ID 목록을 출력합니다.
# Outputs the IDs of the attach subnets.
output "attach_subnet_ids" {
  description = "The IDs of the attach subnets (general-purpose subnets)"
  value       = aws_subnet.attach[*].id
}

# Output: Attach 서브넷 태그 / Attach Subnet Tags
# 생성된 Attach 서브넷의 태그를 출력합니다.
# Outputs the tags of the attach subnets.
output "attach_subnet_tags" {
  description = "The tags of the attach subnets"
  value       = { for subnet in aws_subnet.attach : subnet.id => subnet.tags }
}