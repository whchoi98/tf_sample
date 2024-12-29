# 환경 이름 / Environment Name
# 배포 환경 이름(dev, staging, prod)을 정의합니다.
# Defines the environment name (e.g., dev, staging, prod).
variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

# AWS 리전 / AWS Region
# 리소스를 배포할 AWS 리전을 정의합니다.
# Defines the AWS region where resources will be deployed.
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
}

# 가용 영역 / Availability Zones
# 리소스를 배포할 가용 영역 목록을 정의합니다.
# Defines the list of availability zones to use for resource deployment.
variable "azs" {
  description = "The availability zones to use"
  type        = list(string)
  default     = ["a", "b", "c"]
}

# VPC ID 변수 / VPC ID Variable
# 보안 그룹이 연결될 VPC의 ID를 정의합니다.
# Defines the ID of the VPC associated with the security groups.
#variable "vpc_id" {
#  description = "ID of the VPC" # VPC ID
#  type        = string         # 문자열 타입 / String type
#}

# NAT Gateway ID 변수 / NAT Gateway ID Variable
# NAT Gateway의 ID를 정의합니다.
# Defines the ID of the NAT Gateway.
#variable "nat_gateway_id" {
#  description = "The ID of the NAT Gateway" # NAT Gateway ID
#  type        = string                     # 문자열 타입 / String type
#}

# VPC CIDR / VPC CIDR Block
# VPC의 CIDR 블록을 정의합니다.
# Defines the CIDR block for the VPC.
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

# 이름 접두사 / Name Prefix
# VPC 및 서브넷 이름에 사용할 접두사를 정의합니다.
# Defines the name prefix for VPC and subnets.
variable "name" {
  description = "The name prefix for the VPC and subnets"
  type        = string
}

# 퍼블릭 서브넷 CIDR / Public Subnet CIDR Blocks
# 퍼블릭 서브넷의 CIDR 블록 목록을 정의합니다.
# Defines the CIDR blocks for public subnets.
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

# 프라이빗 서브넷 CIDR / Private Subnet CIDR Blocks
# 프라이빗 서브넷의 CIDR 블록 목록을 정의합니다.
# Defines the CIDR blocks for private subnets.
variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = [
    "10.0.32.0/19",
    "10.0.64.0/19",
    "10.0.96.0/19"
  ]
}

# Attach 서브넷 CIDR / Attach Subnet CIDR Blocks
# Attach 서브넷의 CIDR 블록 목록을 정의합니다.
# Defines the CIDR blocks for attach subnets.
variable "attach_subnet_cidrs" {
  description = "CIDR blocks for attach subnets"
  type        = list(string)
  default     = [
    "10.0.241.0/24",
    "10.0.242.0/24",
    "10.0.243.0/24"
  ]
}

# DB 서브넷 CIDR / DB Subnet CIDR Blocks
# DB 서브넷의 CIDR 블록 목록을 정의합니다.
# Defines the CIDR blocks for DB subnets.
variable "db_subnet_cidrs" {
  description = "CIDR blocks for DB subnets"
  type        = list(string)
  default     = ["10.0.134.0/24", "10.0.135.0/24", "10.0.136.0/24"]
}

# ElastiCache 서브넷 CIDR / ElastiCache Subnet CIDR Blocks
# ElastiCache 서브넷의 CIDR 블록 목록을 정의합니다.
# Defines the CIDR blocks for ElastiCache subnets.
variable "elasticache_subnet_cidrs" {
  description = "CIDR blocks for ElastiCache subnets"
  type        = list(string)
  default     = ["10.0.131.0/24", "10.0.132.0/24", "10.0.133.0/24"]
}

variable "public_subnet_ids" {
  description = "IDs of public subnets"
  type        = list(string)
}