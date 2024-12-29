# Output: Aurora Cluster Endpoint
output "aurora_cluster_endpoint" {
  description = "The endpoint of the Aurora MySQL cluster"
  value       = aws_rds_cluster.aurora.endpoint
}

# Output: Aurora Reader Endpoint
output "aurora_reader_endpoint" {
  description = "The reader endpoint of the Aurora MySQL cluster"
  value       = aws_rds_cluster.aurora.reader_endpoint
}

# Output: Aurora Cluster ID
output "aurora_cluster_id" {
  description = "The ID of the Aurora MySQL cluster"
  value       = aws_rds_cluster.aurora.id
}

# Output: Aurora Instance Endpoints
output "aurora_instance_endpoints" {
  description = "The endpoints of the Aurora MySQL instances"
  value       = [for instance in aws_rds_cluster_instance.aurora_instances : instance.endpoint]
}

# Output: Aurora Instance IDs
output "aurora_instance_ids" {
  description = "The IDs of the Aurora MySQL instances"
  value       = [for instance in aws_rds_cluster_instance.aurora_instances : instance.id]
}