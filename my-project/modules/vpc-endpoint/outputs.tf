output "ssm_vpc_endpoint_id" {
  description = "The ID of the SSM VPC Endpoint"
  value       = aws_vpc_endpoint.ssm.id
}

output "ssm_vpc_endpoint_dns" {
  description = "The DNS name of the SSM VPC Endpoint"
  value       = aws_vpc_endpoint.ssm.dns_entry[*].dns_name
}

output "ssmmessages_vpc_endpoint_id" {
  description = "The ID of the SSM Messages VPC Endpoint"
  value       = aws_vpc_endpoint.ssmmessages.id
}

output "ssmmessages_vpc_endpoint_dns" {
  description = "The DNS name of the SSM Messages VPC Endpoint"
  value       = aws_vpc_endpoint.ssmmessages.dns_entry[*].dns_name
}