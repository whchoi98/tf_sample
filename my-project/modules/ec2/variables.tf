# AMI ID 변수 / AMI ID variable
# EC2 인스턴스에 사용할 AMI ID를 정의합니다.
# Defines the AMI ID for EC2 instances.
variable "ami_id" {
  description = "AMI ID for EC2 instances" # EC2 인스턴스용 AMI ID
  type        = string                    # 문자열 타입 / String type
}

# EC2 인스턴스 타입 변수 / EC2 Instance Type variable
# EC2 인스턴스의 타입을 정의합니다.
# Defines the instance type for EC2 instances.
variable "instance_type" {
  description = "Instance type for EC2 instances" # EC2 인스턴스 타입
  type        = string                           # 문자열 타입 / String type
}

# 퍼블릭 서브넷 ID 변수 / Public Subnet IDs variable
# 퍼블릭 EC2 인스턴스를 배치할 서브넷의 ID 목록을 정의합니다.
# Defines the list of public subnet IDs for deploying public EC2 instances.
variable "public_subnet_ids" {
  description = "List of public subnet IDs" # 퍼블릭 서브넷 ID 목록
  type        = list(string)               # 문자열 리스트 타입 / List of strings
}

# 프라이빗 서브넷 ID 변수 / Private Subnet IDs variable
# 프라이빗 EC2 인스턴스를 배치할 서브넷의 ID 목록을 정의합니다.
# Defines the list of private subnet IDs for deploying private EC2 instances.
variable "private_subnet_ids" {
  description = "List of private subnet IDs" # 프라이빗 서브넷 ID 목록
  type        = list(string)                # 문자열 리스트 타입 / List of strings
}

# 퍼블릭 EC2 고정 IP 변수 / Public EC2 Fixed IPs variable
# 퍼블릭 EC2 인스턴스에 사용할 고정 IP 목록을 정의합니다.
# Defines the list of fixed private IPs for public EC2 instances.
variable "public_fixed_ips" {
  description = "List of fixed private IPs for Public Subnet EC2 instances" # 퍼블릭 서브넷 EC2 인스턴스용 고정 IP 목록
  type        = list(string)                                             # 문자열 리스트 타입 / List of strings
}

# 프라이빗 EC2 고정 IP 변수 / Private EC2 Fixed IPs variable
# 프라이빗 EC2 인스턴스에 사용할 고정 IP 목록을 정의합니다.
# Defines the list of fixed private IPs for private EC2 instances.
variable "private_fixed_ips" {
  description = "List of fixed private IPs for Private Subnet EC2 instances" # 프라이빗 서브넷 EC2 인스턴스용 고정 IP 목록
  type        = list(string)                                              # 문자열 리스트 타입 / List of strings
}

# 퍼블릭 EC2 보안 그룹 ID 변수 / Public EC2 Security Group ID variable
# 퍼블릭 EC2 인스턴스에 적용할 보안 그룹 ID를 정의합니다.
# Defines the security group ID for public EC2 instances.
variable "public_ec2_security_group_id" {
  description = "Security group ID for Public EC2 instances" # 퍼블릭 EC2 인스턴스용 보안 그룹 ID
  type        = string                                      # 문자열 타입 / String type
}

# 프라이빗 EC2 보안 그룹 ID 변수 / Private EC2 Security Group ID variable
# 프라이빗 EC2 인스턴스에 적용할 보안 그룹 ID를 정의합니다.
# Defines the security group ID for private EC2 instances.
variable "private_ec2_security_group_id" {
  description = "Security group ID for Private EC2 instances" # 프라이빗 EC2 인스턴스용 보안 그룹 ID
  type        = string                                       # 문자열 타입 / String type
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
# Defines common tags applied to all resources.
variable "common_tags" {
  description = "Common tags applied to all resources" # 모든 리소스에 적용할 공통 태그
  type        = map(string)                            # 문자열 맵 타입 / Map of strings
  default     = {}                                     # 기본값: 빈 맵 / Default: empty map
}

# IAM 인스턴스 프로파일 변수 / IAM Instance Profile variable
# EC2 인스턴스에 적용할 IAM 인스턴스 프로파일 ARN을 정의합니다.
# Defines the IAM Instance Profile ARN for EC2 instances.
variable "instance_profile" {
  description = "IAM Instance Profile ARN" # IAM 인스턴스 프로파일 ARN
  type        = string                    # 문자열 타입 / String type
}
