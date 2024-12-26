# IAM 역할 및 인스턴스 프로파일 이름 변수 / Name variable for IAM Role and Instance Profile
# IAM 역할과 인스턴스 프로파일에 사용할 이름을 정의합니다.
# Defines the name to be used for the IAM Role and Instance Profile.
variable "name" {
  description = "Name of the IAM Role and Instance Profile" # IAM 역할 및 인스턴스 프로파일 이름
  type        = string                                    # 문자열 타입 / String type
}

# 환경 변수 / Environment variable
# 배포 환경 이름(dev, staging, prod)을 정의합니다.
# Defines the environment name (e.g., dev, staging, prod).
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)" # 환경 이름 (예: dev, staging, prod)
  type        = string                                       # 문자열 타입 / String type
}

# 공통 태그 변수 / Common Tags variable
# 모든 리소스에 적용할 공통 태그를 정의합니다.
# Defines common tags to be applied to all resources.
variable "common_tags" {
  description = "Common tags for all resources" # 모든 리소스에 적용되는 공통 태그
  type        = map(string)                    # 문자열 맵 타입 / Map of strings
  default     = {}                             # 기본값: 빈 맵 / Default: empty map
}

# IAM Instance Profile Name 변수 / Variable for IAM Instance Profile Name
variable "instance_profile_name" {
  description = "Name of the IAM Instance Profile to associate with the EC2 instances"
  type        = string
}