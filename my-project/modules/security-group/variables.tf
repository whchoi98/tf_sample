# VPC ID 변수 / VPC ID Variable
# 보안 그룹이 연결될 VPC의 ID를 정의합니다.
# Defines the ID of the VPC associated with the security groups.
variable "vpc_id" {
  description = "ID of the VPC" # VPC ID
  type        = string         # 문자열 타입 / String type
}

# 환경 변수 / Environment Variable
# 배포 환경 이름(dev, staging, prod 등)을 정의합니다.
# Defines the environment name (e.g., dev, staging, prod).
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)" # 배포 환경 이름 (예: dev, staging, prod)
  type        = string                                       # 문자열 타입 / String type
}

# 공통 태그 변수 / Common Tags Variable
# 모든 리소스에 적용할 공통 태그를 정의합니다.
# Defines common tags applied to all resources.
variable "common_tags" {
  description = "Common tags applied to all resources" # 모든 리소스에 적용되는 공통 태그
  type        = map(string)                            # 문자열 맵 타입 / Map of strings
  default     = {}                                     # 기본값: 빈 맵 / Default: empty map
}

