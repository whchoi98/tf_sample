# 라우팅 리소스 이름 접두사 변수 / Name Prefix for Routing Resources
# 라우팅 리소스에 사용할 이름 접두사를 정의합니다.
# Defines the name prefix to be used for routing resources.
variable "name" {
  description = "The name prefix for the routing resources" # 라우팅 리소스 이름 접두사
  type        = string                                     # 문자열 타입 / String type
}

# 환경 변수 / Environment Variable
# 배포 환경 이름(dev, staging, prod 등)을 정의합니다.
# Defines the environment name (e.g., dev, staging, prod).
variable "environment" {
  description = "The environment (e.g., dev, staging, prod)" # 배포 환경 (예: dev, staging, prod)
  type        = string                                      # 문자열 타입 / String type
}

# VPC ID 변수 / VPC ID Variable
# 라우팅 리소스가 연결될 VPC의 ID를 정의합니다.
# Defines the ID of the VPC associated with the routing resources.
variable "vpc_id" {
  description = "The ID of the VPC" # VPC ID
  type        = string             # 문자열 타입 / String type
}

# 퍼블릭 서브넷 ID 변수 / Public Subnet IDs Variable
# 퍼블릭 서브넷의 ID 목록을 정의합니다.
# Defines the IDs of the public subnets.
variable "public_subnet_ids" {
  description = "The IDs of the public subnets" # 퍼블릭 서브넷 ID 목록
  type        = list(string)                   # 문자열 리스트 타입 / List of strings
}

# 프라이빗 서브넷 ID 변수 / Private Subnet IDs Variable
# 프라이빗 서브넷의 ID 목록을 정의합니다.
# Defines the IDs of the private subnets.
variable "private_subnet_ids" {
  description = "The IDs of the private subnets" # 프라이빗 서브넷 ID 목록
  type        = list(string)                    # 문자열 리스트 타입 / List of strings
}

# Attach 서브넷 ID 변수 / Attach Subnet IDs Variable
# Attach 서브넷의 ID 목록을 정의합니다.
# Defines the IDs of the attach subnets.
variable "attach_subnet_ids" {
  description = "The IDs of the attach subnets" # Attach 서브넷 ID 목록
  type        = list(string)                   # 문자열 리스트 타입 / List of strings
}

# DB 서브넷 ID 변수 / DB Subnet IDs Variable
# DB 서브넷의 ID 목록을 정의합니다.
# Defines the IDs of the DB subnets.
variable "db_subnet_ids" {
  description = "The IDs of the DB subnets" # DB 서브넷 ID 목록
  type        = list(string)               # 문자열 리스트 타입 / List of strings
}

# ElastiCache 서브넷 ID 변수 / ElastiCache Subnet IDs Variable
# ElastiCache 서브넷의 ID 목록을 정의합니다.
# Defines the IDs of the ElastiCache subnets.
variable "elasticache_subnet_ids" {
  description = "The IDs of the ElastiCache subnets" # ElastiCache 서브넷 ID 목록
  type        = list(string)                        # 문자열 리스트 타입 / List of strings
}

# NAT Gateway ID 변수 / NAT Gateway ID Variable
# NAT Gateway의 ID를 정의합니다.
# Defines the ID of the NAT Gateway.
variable "nat_gateway_id" {
  description = "The ID of the NAT Gateway" # NAT Gateway ID
  type        = string                     # 문자열 타입 / String type
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}