# Output: EC2 인스턴스 ID / EC2 Instance IDs
# 생성된 모든 EC2 인스턴스의 ID를 출력합니다.
# Outputs the IDs of all created EC2 instances.
output "instance_ids" {
  description = "IDs of all EC2 instances" # 모든 EC2 인스턴스의 ID
  value       = concat(
    values(aws_instance.public_ec2)[*].id,  # 퍼블릭 EC2 인스턴스의 ID 목록
    values(aws_instance.private_ec2)[*].id # 프라이빗 EC2 인스턴스의 ID 목록
  )
}

# Output: 첫 번째 프라이빗 인스턴스 ID / First Private Instance ID
# 첫 번째 프라이빗 EC2 인스턴스의 ID를 출력합니다.
# Outputs the ID of the first private EC2 instance.
output "private_instance_1_id" {
  description = "ID of the first private EC2 instance" # 첫 번째 프라이빗 EC2 인스턴스의 ID
  value       = aws_instance.private_ec2["10.0.32.11"].id
}

# Output: 두 번째 프라이빗 인스턴스 ID / Second Private Instance ID
# 두 번째 프라이빗 EC2 인스턴스의 ID를 출력합니다.
# Outputs the ID of the second private EC2 instance.
output "private_instance_2_id" {
  description = "ID of the second private EC2 instance" # 두 번째 프라이빗 EC2 인스턴스의 ID
  value       = aws_instance.private_ec2["10.0.32.12"].id
}

# Output: EC2 프라이빗 IP / EC2 Private IPs
# 생성된 모든 EC2 인스턴스의 프라이빗 IP를 출력합니다.
# Outputs the private IPs of all created EC2 instances.
output "private_ips" {
  description = "Private IPs of all EC2 instances" # 모든 EC2 인스턴스의 프라이빗 IP
  value       = concat(
    keys(aws_instance.public_ec2),  # 퍼블릭 EC2 인스턴스의 프라이빗 IP 목록
    keys(aws_instance.private_ec2) # 프라이빗 EC2 인스턴스의 프라이빗 IP 목록
  )
}

# Output: EC2 퍼블릭 IP / EC2 Public IPs
# 생성된 퍼블릭 EC2 인스턴스의 퍼블릭 IP를 출력합니다.
# Outputs the public IPs of all public EC2 instances.
output "public_ips" {
  description = "Public IPs of all Public EC2 instances" # 모든 퍼블릭 EC2 인스턴스의 퍼블릭 IP
  value       = [for instance in values(aws_instance.public_ec2) : instance.public_ip]
}

# Output: EC2 인스턴스 이름 / EC2 Instance Names
# 생성된 모든 EC2 인스턴스의 이름을 출력합니다.
# Outputs the names of all created EC2 instances.
output "instance_names" {
  description = "Names of all EC2 instances" # 모든 EC2 인스턴스의 이름
  value       = concat(
    [for instance in values(aws_instance.public_ec2) : instance.tags["Name"]], # 퍼블릭 EC2 인스턴스의 이름 목록
    [for instance in values(aws_instance.private_ec2) : instance.tags["Name"]] # 프라이빗 EC2 인스턴스의 이름 목록
  )
}