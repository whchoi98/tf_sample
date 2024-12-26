# 이름 접두사 / Name Prefix
variable "name" {
  description = "The name prefix for the VPC and subnets"
  type        = string
}

# 환경 이름 / Environment Name
variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

# AWS 리전 / AWS Region
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
}

# 가용 영역 / Availability Zones
variable "azs" {
  description = "The availability zones to use"
  type        = list(string)
  default     = ["a", "b", "c"]
}

# VPC CIDR / VPC CIDR Block
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

# 퍼블릭 서브넷 CIDR / Public Subnet CIDR Blocks
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

# 프라이빗 서브넷 CIDR / Private Subnet CIDR Blocks
variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

# Attach 서브넷 CIDR / Attach Subnet CIDR Blocks
variable "attach_subnet_cidrs" {
  description = "CIDR blocks for attach subnets"
  type        = list(string)
}

# DB 서브넷 CIDR / DB Subnet CIDR Blocks
variable "db_subnet_cidrs" {
  description = "CIDR blocks for DB subnets"
  type        = list(string)
  default     = ["10.0.128.0/24", "10.0.129.0/24", "10.0.130.0/24"]
}