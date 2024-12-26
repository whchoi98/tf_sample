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
# 생성된 SSM IAM 인스턴스 프로파일의 이름을 출력합니다.
# Outputs the name of the created SSM instance profile.
output "ssm_instance_profile_name" {
  description = "Name of the SSM Instance Profile" # SSM 인스턴스 프로파일의 이름
  value       = aws_iam_instance_profile.ssm_instance_profile.name # SSM IAM 인스턴스 프로파일의 이름 / Name of the SSM IAM instance profile
}

# Output: SSM IAM 역할 정책 ARN 목록 / List of SSM IAM Role Policy ARNs
# SSM IAM 역할에 연결된 모든 정책의 ARN을 출력합니다.
# Outputs the list of ARNs of the policies attached to the SSM IAM role.
output "ssm_role_policy_arns" {
  description = "List of ARNs of the policies attached to the SSM Role" # SSM 역할에 연결된 정책 ARN 목록
  value       = [for attachment in aws_iam_role_policy_attachment.ssm_role : attachment.policy_arn] # 역할에 연결된 정책 ARN / List of policy ARNs attached to the role
}

# Output: 모든 태그 / All Tags
# IAM 리소스에 적용된 모든 태그를 출력합니다.
# Outputs all tags applied to the IAM resources.
output "tags" {
  description = "Tags applied to IAM resources" # IAM 리소스에 적용된 태그
  value       = var.common_tags                 # 공통 태그 출력 / Common tags output
}