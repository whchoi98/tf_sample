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

# Output: ElastiCache Route Table IDs / ElastiCache Route Table ID 목록
# 생성된 ElastiCache Route Table의 ID 목록을 출력합니다.
# Outputs the IDs of the created ElastiCache Route Tables.
output "elasticache_route_table_ids" {
  description = "The IDs of the ElastiCache Route Tables" # ElastiCache Route Table ID 목록
  value       = aws_route_table.elasticache[*].id        # ElastiCache Route Table의 ID 목록 / List of ElastiCache Route Table IDs
}

# Output: DB Route Table IDs / DB Route Table ID 목록
# 생성된 DB Route Table의 ID 목록을 출력합니다.
# Outputs the IDs of the created DB Route Tables.
output "db_route_table_ids" {
  description = "The IDs of the DB Route Tables" # DB Route Table ID 목록
  value       = aws_route_table.db[*].id        # DB Route Table의 ID 목록 / List of DB Route Table IDs
}


