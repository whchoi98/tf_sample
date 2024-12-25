output "ssm_security_group_id" {
  description = "ID of the SSM Security Group"
  value       = aws_security_group.ssm.id
}

output "alb_security_group_id" {
  description = "ID of the ALB Security Group"
  value       = aws_security_group.alb.id
}

output "nlb_security_group_id" {
  description = "ID of the NLB Security Group"
  value       = aws_security_group.nlb.id
}

output "public_ec2_security_group_id" {
  description = "ID of the Public EC2 Security Group"
  value       = aws_security_group.public_ec2.id
}

output "private_ec2_security_group_id" {
  description = "ID of the Private EC2 Security Group"
  value       = aws_security_group.private_ec2.id
}