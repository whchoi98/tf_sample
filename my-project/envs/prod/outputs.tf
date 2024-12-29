# Aurora 클러스터 엔드포인트 / Aurora Cluster Endpoint
output "aurora_cluster_endpoint" {
  description = "The endpoint of the Aurora cluster"
  value       = module.aurora.cluster_endpoint
}

# Aurora 클러스터 Reader 엔드포인트 / Aurora Cluster Reader Endpoint
output "aurora_reader_endpoint" {
  description = "The reader endpoint of the Aurora cluster"
  value       = module.aurora.reader_endpoint
}

# Aurora DB 인스턴스 엔드포인트 목록 / Aurora DB Instance Endpoints
output "aurora_instance_endpoints" {
  description = "The endpoints of Aurora DB instances"
  value       = module.aurora.instance_endpoints
}

# Aurora DB 클러스터 ARN / Aurora DB Cluster ARN
output "aurora_cluster_arn" {
  description = "The ARN of the Aurora cluster"
  value       = module.aurora.cluster_arn
}