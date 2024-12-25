output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.main.id
}

output "public_route_table_ids" {
  description = "The IDs of the Public Route Tables"
  value       = aws_route_table.public[*].id
}

output "private_route_table_ids" {
  description = "The IDs of the Private Route Tables"
  value       = aws_route_table.private[*].id
}

output "attach_route_table_ids" {
  description = "The IDs of the Attach Route Tables"
  value       = aws_route_table.attach[*].id
}