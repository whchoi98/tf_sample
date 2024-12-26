# Output: SSM 보안 그룹 ID / SSM Security Group ID
# 생성된 SSM 보안 그룹의 ID를 출력합니다.
# Outputs the ID of the created SSM Security Group.
output "ssm_security_group_id" {
  description = "ID of the SSM Security Group" # SSM 보안 그룹 ID
  value       = aws_security_group.ssm.id     # SSM 보안 그룹의 ID / ID of the SSM Security Group
}

# Output: ALB 보안 그룹 ID / ALB Security Group ID
# 생성된 ALB 보안 그룹의 ID를 출력합니다.
# Outputs the ID of the created ALB Security Group.
output "alb_security_group_id" {
  description = "ID of the ALB Security Group" # ALB 보안 그룹 ID
  value       = aws_security_group.alb.id     # ALB 보안 그룹의 ID / ID of the ALB Security Group
}

# Output: NLB 보안 그룹 ID / NLB Security Group ID
# 생성된 NLB 보안 그룹의 ID를 출력합니다.
# Outputs the ID of the created NLB Security Group.
output "nlb_security_group_id" {
  description = "ID of the NLB Security Group" # NLB 보안 그룹 ID
  value       = aws_security_group.nlb.id     # NLB 보안 그룹의 ID / ID of the NLB Security Group
}

# Output: 퍼블릭 EC2 보안 그룹 ID / Public EC2 Security Group ID
# 생성된 퍼블릭 EC2 보안 그룹의 ID를 출력합니다.
# Outputs the ID of the created Public EC2 Security Group.
output "public_ec2_security_group_id" {
  description = "ID of the Public EC2 Security Group" # 퍼블릭 EC2 보안 그룹 ID
  value       = aws_security_group.public_ec2.id     # 퍼블릭 EC2 보안 그룹의 ID / ID of the Public EC2 Security Group
}

# Output: 프라이빗 EC2 보안 그룹 ID / Private EC2 Security Group ID
# 생성된 프라이빗 EC2 보안 그룹의 ID를 출력합니다.
# Outputs the ID of the created Private EC2 Security Group.
output "private_ec2_security_group_id" {
  description = "ID of the Private EC2 Security Group" # 프라이빗 EC2 보안 그룹 ID
  value       = aws_security_group.private_ec2.id     # 프라이빗 EC2 보안 그룹의 ID / ID of the Private EC2 Security Group
}