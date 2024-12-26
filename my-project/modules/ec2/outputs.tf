# Output: EC2 인스턴스 ID / EC2 Instance IDs
# 생성된 모든 EC2 인스턴스의 ID를 출력합니다.
# Outputs the IDs of all created EC2 instances.
output "instance_ids" {
  description = "IDs of all EC2 instances" # 모든 EC2 인스턴스의 ID
  value       = concat(
    aws_instance.public_ec2[*].id, # 퍼블릭 EC2 인스턴스의 ID 목록 / List of public EC2 instance IDs
    aws_instance.private_ec2[*].id # 프라이빗 EC2 인스턴스의 ID 목록 / List of private EC2 instance IDs
  )
}

# Output: EC2 프라이빗 IP / EC2 Private IPs
# 생성된 모든 EC2 인스턴스의 프라이빗 IP를 출력합니다.
# Outputs the private IPs of all created EC2 instances.
output "private_ips" {
  description = "Private IPs of all EC2 instances" # 모든 EC2 인스턴스의 프라이빗 IP
  value       = concat(
    aws_instance.public_ec2[*].private_ip, # 퍼블릭 EC2 인스턴스의 프라이빗 IP 목록 / List of public EC2 private IPs
    aws_instance.private_ec2[*].private_ip # 프라이빗 EC2 인스턴스의 프라이빗 IP 목록 / List of private EC2 private IPs
  )
}

# Output: EC2 퍼블릭 IP / EC2 Public IPs
# 생성된 퍼블릭 EC2 인스턴스의 퍼블릭 IP를 출력합니다.
# Outputs the public IPs of all public EC2 instances.
output "public_ips" {
  description = "Public IPs of all Public EC2 instances" # 모든 퍼블릭 EC2 인스턴스의 퍼블릭 IP
  value       = aws_instance.public_ec2[*].public_ip # 퍼블릭 EC2 인스턴스의 퍼블릭 IP 목록 / List of public EC2 public IPs
}

# Output: EC2 인스턴스 이름 / EC2 Instance Names
# 생성된 모든 EC2 인스턴스의 이름을 출력합니다.
# Outputs the names of all created EC2 instances.
output "instance_names" {
  description = "Names of all EC2 instances" # 모든 EC2 인스턴스의 이름
  value       = concat(
    [for instance in aws_instance.public_ec2 : instance.tags["Name"]], # 퍼블릭 EC2 인스턴스의 이름 목록 / List of public EC2 instance names
    [for instance in aws_instance.private_ec2 : instance.tags["Name"]] # 프라이빗 EC2 인스턴스의 이름 목록 / List of private EC2 instance names
  )
}