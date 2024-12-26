# Output: VPC ID / VPC ID
# 생성된 VPC의 ID를 출력합니다.
# Outputs the ID of the created VPC.
output "vpc_id" {
  description = "The ID of the created VPC" # 생성된 VPC의 ID
  value       = aws_vpc.main.id            # VPC의 ID / ID of the VPC
}

# Output: 퍼블릭 서브넷 ID / Public Subnet IDs
# 생성된 퍼블릭 서브넷의 ID 목록을 출력합니다.
# Outputs the IDs of the public subnets.
output "public_subnet_ids" {
  description = "The IDs of the public subnets (used for internet-facing EKS load balancers)" # 퍼블릭 서브넷의 ID 목록 (인터넷을 사용하는 EKS 로드 밸런서에 사용됨)
  value       = aws_subnet.public[*].id                                                    # 퍼블릭 서브넷 ID / Public subnet IDs
}

# Output: 퍼블릭 서브넷 태그 / Public Subnet Tags
# 생성된 퍼블릭 서브넷의 태그를 출력합니다.
# Outputs the tags of the public subnets.
output "public_subnet_tags" {
  description = "The tags of the public subnets (EKS-related)" # 퍼블릭 서브넷의 태그 (EKS 관련)
  value       = { for subnet in aws_subnet.public : subnet.id => subnet.tags } # 퍼블릭 서브넷의 태그 / Tags of public subnets
}

# Output: 프라이빗 서브넷 ID / Private Subnet IDs
# 생성된 프라이빗 서브넷의 ID 목록을 출력합니다.
# Outputs the IDs of the private subnets.
output "private_subnet_ids" {
  description = "The IDs of the private subnets (used for internal-facing EKS load balancers)" # 프라이빗 서브넷의 ID 목록 (내부용 EKS 로드 밸런서에 사용됨)
  value       = aws_subnet.private[*].id                                                     # 프라이빗 서브넷 ID / Private subnet IDs
}

# Output: 프라이빗 서브넷 태그 / Private Subnet Tags
# 생성된 프라이빗 서브넷의 태그를 출력합니다.
# Outputs the tags of the private subnets.
output "private_subnet_tags" {
  description = "The tags of the private subnets (EKS-related)" # 프라이빗 서브넷의 태그 (EKS 관련)
  value       = { for subnet in aws_subnet.private : subnet.id => subnet.tags } # 프라이빗 서브넷의 태그 / Tags of private subnets
}

# Output: Attach 서브넷 ID / Attach Subnet IDs
# 생성된 Attach 서브넷의 ID 목록을 출력합니다.
# Outputs the IDs of the attach subnets.
output "attach_subnet_ids" {
  description = "The IDs of the attach subnets (general-purpose subnets)" # Attach 서브넷의 ID 목록 (일반 용도 서브넷)
  value       = aws_subnet.attach[*].id                                   # Attach 서브넷 ID / Attach subnet IDs
}

# Output: Attach 서브넷 태그 / Attach Subnet Tags
# 생성된 Attach 서브넷의 태그를 출력합니다.
# Outputs the tags of the attach subnets.
output "attach_subnet_tags" {
  description = "The tags of the attach subnets" # Attach 서브넷의 태그
  value       = { for subnet in aws_subnet.attach : subnet.id => subnet.tags } # Attach 서브넷의 태그 / Tags of attach subnets
}