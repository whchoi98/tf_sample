# VPC 및 서브넷 이름 접두사 변수 / Name Prefix for VPC and Subnets
# VPC와 서브넷 리소스에 사용할 이름 접두사를 정의합니다.
# Defines the name prefix to be used for the VPC and subnet resources.
variable "name" {
  description = "The name prefix for the VPC and subnets" # VPC 및 서브넷의 이름 접두사
  type        = string                                   # 문자열 타입 / String type
}

# 환경 변수 / Environment Variable
# 배포 환경 이름(dev, staging, prod 등)을 정의합니다.
# Defines the environment name (e.g., dev, staging, prod).
variable "environment" {
  description = "The environment (e.g., dev, staging, prod)" # 배포 환경 (예: dev, staging, prod)
  type        = string                                      # 문자열 타입 / String type
}

# AWS 리전 변수 / AWS Region Variable
# 리소스가 배포될 AWS 리전을 정의합니다.
# Defines the AWS region where the resources will be deployed.
variable "region" {
  description = "The AWS region to deploy resources" # 리소스를 배포할 AWS 리전
  type        = string                              # 문자열 타입 / String type
}

# 가용 영역 변수 / Availability Zones Variable
# 리소스를 배포할 가용 영역 목록을 정의합니다.
# Defines the list of availability zones to use for resource deployment.
variable "azs" {
  description = "The availability zones to use" # 사용할 가용 영역
  type        = list(string)                   # 문자열 리스트 타입 / List of strings
  default     = ["a", "b", "c"]                # 기본값: ["a", "b", "c"] / Default: ["a", "b", "c"]
}

# VPC CIDR 블록 변수 / VPC CIDR Block Variable
# VPC의 CIDR 블록을 정의합니다.
# Defines the CIDR block for the VPC.
variable "cidr" {
  description = "The CIDR block for the VPC" # VPC의 CIDR 블록
  type        = string                      # 문자열 타입 / String type
}

# 퍼블릭 서브넷 CIDR 블록 변수 / Public Subnet CIDR Blocks Variable
# 퍼블릭 서브넷의 CIDR 블록 목록을 정의합니다.
# Defines the CIDR blocks for public subnets.
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets" # 퍼블릭 서브넷의 CIDR 블록
  type        = list(string)                    # 문자열 리스트 타입 / List of strings
}

# 프라이빗 서브넷 CIDR 블록 변수 / Private Subnet CIDR Blocks Variable
# 프라이빗 서브넷의 CIDR 블록 목록을 정의합니다.
# Defines the CIDR blocks for private subnets.
variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets" # 프라이빗 서브넷의 CIDR 블록
  type        = list(string)                     # 문자열 리스트 타입 / List of strings
}

# Attach 서브넷 CIDR 블록 변수 / Attach Subnet CIDR Blocks Variable
# Attach 서브넷의 CIDR 블록 목록을 정의합니다.
# Defines the CIDR blocks for attach subnets.
variable "attach_subnet_cidrs" {
  description = "CIDR blocks for attach subnets" # Attach 서브넷의 CIDR 블록
  type        = list(string)                    # 문자열 리스트 타입 / List of strings
}