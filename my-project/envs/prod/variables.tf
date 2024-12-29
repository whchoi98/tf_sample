# AWS 리전 변수 / AWS Region Variable
# 리소스가 배포될 AWS 리전을 정의합니다. / Defines the AWS region where resources will be deployed.
variable "region" {
  description = "AWS Region" # AWS 리전
  type        = string       # 문자열 타입 / String type
  default     = "ap-northeast-2" # 기본값: ap-northeast-2 / Default: ap-northeast-2
}

# 환경 변수 / Environment Variable
# 배포 환경 이름(dev, staging, prod 등)을 정의합니다.
# Defines the deployment environment name (e.g., dev, staging, prod).
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)" # 환경 이름 (예: dev, staging, prod)
  type        = string                                       # 문자열 타입 / String type
  default     = "prod"                                       # 기본값: prod / Default: prod
}

# 공통 태그 변수 / Common tags variable
# 모든 리소스에 적용할 공통 태그를 정의합니다. / Defines common tags applied to all resources.
variable "common_tags" {
  description = "Common tags applied to all resources" # 모든 리소스에 적용되는 공통 태그
  type        = map(string)                            # 문자열 맵 타입 / Map of strings
  default     = {                                      # 기본값 / Default value
    Environment = "prod"                               # 환경 이름 태그 / Environment name tag
    Owner       = "team-prod"                          # 소유자 태그 / Owner tag
  }
}

# 퍼블릭 서브넷 ID 변수 / Public subnet IDs variable
# 퍼블릭 서브넷의 ID 목록을 정의합니다. / Defines the list of public subnet IDs.
#variable "public_subnet_ids" {
#  description = "List of public subnet IDs" # 퍼블릭 서브넷 ID 목록
#  type        = list(string)               # 문자열 리스트 타입 / List of strings
#}

# 프라이빗 서브넷 ID 변수 / Private subnet IDs variable
# 프라이빗 서브넷의 ID 목록을 정의합니다. / Defines the list of private subnet IDs.
#variable "private_subnet_ids" {
#  description = "List of private subnet IDs" # 프라이빗 서브넷 ID 목록
#  type        = list(string)                # 문자열 리스트 타입 / List of strings
#}

# VPC ID 변수 / VPC ID variable
# 리소스가 연결될 VPC의 ID를 정의합니다. / Defines the ID of the VPC to which resources are connected.
#variable "vpc_id" {
#  description = "VPC ID" # VPC ID
#  type        = string   # 문자열 타입 / String type
#}

# 스택 이름 변수 / Stack name variable
# 스택의 이름을 정의합니다. / Defines the name of the stack.
variable "stack_name" {
  description = "The name of the stack" # 스택 이름
  type        = string                 # 문자열 타입 / String type
}

# IAM 인스턴스 프로파일 변수 / IAM Instance Profile variable
# EC2 인스턴스에 사용할 IAM 인스턴스 프로파일 ARN을 정의합니다. / Defines the ARN of the IAM instance profile for EC2 instances.
#variable "instance_profile" {
#  description = "IAM Instance Profile ARN" # IAM 인스턴스 프로파일 ARN
#  type        = string                     # 문자열 타입 / String type
#}

# Aurora DB 비밀번호 / Aurora DB Password
variable "db_password" {
  description = "The master password for the Aurora database"
  type        = string
  sensitive   = true
}

# Aurora 인스턴스 개수 / Aurora Instance Count
variable "aurora_instance_count" {
  description = "The number of Aurora DB instances"
  type        = number
  default     = 3
}

# Aurora 엔진 버전 / Aurora Engine Version
variable "aurora_engine_version" {
  description = "The engine version for Aurora MySQL"
  type        = string
  default     = "8.0.mysql_aurora.3.05.2"  # 최신 엔진 버전
}