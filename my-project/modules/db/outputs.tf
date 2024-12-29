# Output: Aurora Cluster Endpoint
output "cluster_endpoint" {
  description = "The endpoint of the Aurora MySQL cluster"
  value       = aws_rds_cluster.aurora.endpoint
}

# Output: Aurora Reader Endpoint
output "reader_endpoint" {
  description = "The reader endpoint of the Aurora MySQL cluster"
  value       = aws_rds_cluster.aurora.reader_endpoint
}

# Output: Aurora Cluster ID
output "cluster_id" {
  description = "The ID of the Aurora MySQL cluster"
  value       = aws_rds_cluster.aurora.id
}

# Output: Aurora Instance Endpoints
output "instance_endpoints" {
  description = "The endpoints of the Aurora MySQL instances"
  value       = [for instance in aws_rds_cluster_instance.instances : instance.endpoint]
}

# Output: Aurora Instance IDs
output "instance_ids" {
  description = "The IDs of the Aurora MySQL instances"
  value       = [for instance in aws_rds_cluster_instance.instances : instance.id]
}

# Aurora 클러스터 ARN / Aurora Cluster ARN
output "cluster_arn" {
  description = "The ARN of the Aurora cluster" # Aurora 클러스터 ARN
  value       = aws_rds_cluster.aurora.arn
}