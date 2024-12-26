# Output: Internet Gateway ID / 인터넷 게이트웨이 ID
# 생성된 인터넷 게이트웨이의 ID를 출력합니다.
# Outputs the ID of the created Internet Gateway.
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway" # 인터넷 게이트웨이 ID
  value       = aws_internet_gateway.main.id    # 인터넷 게이트웨이의 ID / Internet Gateway ID
}

# Output: NAT Gateway ID / NAT 게이트웨이 ID
# 생성된 NAT 게이트웨이의 ID를 출력합니다.
# Outputs the ID of the created NAT Gateway.
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway" # NAT 게이트웨이 ID
  value       = aws_nat_gateway.main.id    # NAT 게이트웨이의 ID / NAT Gateway ID
}

# Output: Public Route Table IDs / 퍼블릭 Route Table ID 목록
# 생성된 퍼블릭 Route Table의 ID 목록을 출력합니다.
# Outputs the IDs of the created Public Route Tables.
output "public_route_table_ids" {
  description = "The IDs of the Public Route Tables" # 퍼블릭 Route Table ID 목록
  value       = aws_route_table.public[*].id        # 퍼블릭 Route Table의 ID 목록 / List of Public Route Table IDs
}

# Output: Private Route Table IDs / 프라이빗 Route Table ID 목록
# 생성된 프라이빗 Route Table의 ID 목록을 출력합니다.
# Outputs the IDs of the created Private Route Tables.
output "private_route_table_ids" {
  description = "The IDs of the Private Route Tables" # 프라이빗 Route Table ID 목록
  value       = aws_route_table.private[*].id        # 프라이빗 Route Table의 ID 목록 / List of Private Route Table IDs
}

# Output: Attach Route Table IDs / Attach Route Table ID 목록
# 생성된 Attach Route Table의 ID 목록을 출력합니다.
# Outputs the IDs of the created Attach Route Tables.
output "attach_route_table_ids" {
  description = "The IDs of the Attach Route Tables" # Attach Route Table ID 목록
  value       = aws_route_table.attach[*].id        # Attach Route Table의 ID 목록 / List of Attach Route Table IDs
}