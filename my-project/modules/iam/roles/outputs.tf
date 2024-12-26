# Output: SSM 역할 ARN / SSM Role ARN
# 생성된 SSM IAM 역할의 ARN을 출력합니다.
# Outputs the ARN of the created SSM IAM role.
output "ssm_role_arn" {
  description = "ARN of the SSM Role" # SSM 역할의 ARN
  value       = aws_iam_role.ssm_role.arn # SSM IAM 역할의 ARN / ARN of the SSM IAM role
}

# Output: SSM 인스턴스 프로파일 ARN / SSM Instance Profile ARN
# 생성된 SSM IAM 인스턴스 프로파일의 ARN을 출력합니다.
# Outputs the ARN of the created SSM IAM instance profile.
output "ssm_instance_profile_arn" {
  description = "ARN of the SSM Instance Profile" # SSM 인스턴스 프로파일의 ARN
  value       = aws_iam_instance_profile.ssm_instance_profile.arn # SSM IAM 인스턴스 프로파일의 ARN / ARN of the SSM IAM instance profile
}

# Output: SSM 인스턴스 프로파일 이름 / SSM Instance Profile Name
# 생성된 SSM 인스턴스 프로파일의 이름을 출력합니다.
# Outputs the name of the created SSM instance profile.
output "ssm_instance_profile_name" {
  description = "Name of the SSM Instance Profile" # SSM 인스턴스 프로파일의 이름
  value       = aws_iam_instance_profile.ssm_instance_profile.name # SSM IAM 인스턴스 프로파일의 이름 / Name of the SSM IAM instance profile
}