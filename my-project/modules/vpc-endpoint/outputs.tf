# SSM VPC Endpoint ID 출력 / Output the SSM VPC Endpoint ID
output "ssm_vpc_endpoint_id" {
  description = "ID of the SSM VPC Endpoint"
  value       = aws_vpc_endpoint.ssm.id
}

# SSM Messages VPC Endpoint ID 출력 / Output the SSM Messages VPC Endpoint ID
output "ssmmessages_vpc_endpoint_id" {
  description = "ID of the SSM Messages VPC Endpoint"
  value       = aws_vpc_endpoint.ssmmessages.id
}