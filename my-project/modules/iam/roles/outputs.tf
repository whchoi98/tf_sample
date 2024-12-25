output "ssm_role_arn" {
  description = "ARN of the SSM Role"
  value       = aws_iam_role.ssm_role.arn
}

output "ssm_instance_profile_arn" {
  description = "ARN of the SSM Instance Profile"
  value       = aws_iam_instance_profile.ssm_instance_profile.arn
}