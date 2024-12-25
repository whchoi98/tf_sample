# VPC ID를 정의하는 변수 / Variable for defining the VPC ID
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

# AWS 리전 정의 / Define AWS Region
variable "region" {
  description = "AWS Region"
  type        = string
}

# VPC Endpoint를 연결할 Private Subnet ID 목록 / List of Private Subnet IDs for VPC Endpoints
variable "private_subnet_ids" {
  description = "List of private subnet IDs for VPC Endpoints"
  type        = list(string)
}

# VPC Endpoint에 연결할 Security Group ID / Security Group ID for VPC Endpoints
variable "ssm_security_group_id" {
  description = "Security Group ID for SSM VPC Endpoint"
  type        = string
}

# 환경 이름 (예: dev, staging, prod) / Environment name (e.g., dev, staging, prod)
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

# 공통 태그 정의 / Define common tags
variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}