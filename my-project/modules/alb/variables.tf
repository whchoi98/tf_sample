# 스택 이름 변수 / Stack name variable
# 리소스 그룹에 사용할 스택 이름을 정의합니다. / Defines the stack name for grouping resources.
variable "stack_name" {
  description = "The name of the stack" # 스택 이름
  type        = string                 # 문자열 타입 / String type
}

# VPC ID 변수 / VPC ID variable
# ALB가 연결될 VPC의 ID를 정의합니다. / Defines the VPC ID to which the ALB will be attached.
variable "vpc_id" {
  description = "VPC ID" # VPC ID
  type        = string   # 문자열 타입 / String type
}

# 퍼블릭 서브넷 변수 / Public subnets variable
# ALB가 배치될 퍼블릭 서브넷 목록을 정의합니다. / Defines the list of public subnets where the ALB will be deployed.
variable "public_subnets" {
  description = "List of public subnets" # 퍼블릭 서브넷 목록
  type        = list(string)             # 문자열 리스트 타입 / List of strings
}

# ALB 보안 그룹 ID 변수 / ALB Security Group ID variable
# ALB에 적용할 보안 그룹의 ID를 정의합니다. / Defines the security group ID to be applied to the ALB.
variable "alb_security_group_id" {
  description = "Security group ID for ALB" # ALB 보안 그룹 ID
  type        = string                     # 문자열 타입 / String type
}

# 프라이빗 EC2 인스턴스 1 ID 변수 / Private EC2 instance 1 ID variable
# ALB 타겟 그룹의 첫 번째 EC2 인스턴스 ID를 정의합니다. / Defines the ID of the first EC2 instance in the ALB target group.
variable "private_instance_1_id" {
  description = "Instance ID for private EC2 instance 1" # 프라이빗 EC2 인스턴스 1 ID
  type        = string                                  # 문자열 타입 / String type
}

# 프라이빗 EC2 인스턴스 2 ID 변수 / Private EC2 instance 2 ID variable
# ALB 타겟 그룹의 두 번째 EC2 인스턴스 ID를 정의합니다. / Defines the ID of the second EC2 instance in the ALB target group.
variable "private_instance_2_id" {
  description = "Instance ID for private EC2 instance 2" # 프라이빗 EC2 인스턴스 2 ID
  type        = string                                  # 문자열 타입 / String type
}

# 공통 태그 변수 / Common tags variable
# 모든 리소스에 적용할 공통 태그를 정의합니다. / Defines common tags applied to all resources.
variable "common_tags" {
  description = "Common tags applied to all resources" # 모든 리소스에 적용되는 공통 태그
  type        = map(string)                            # 문자열 맵 타입 / Map of strings
  default     = {                                      # 기본값 / Default value
    Environment = "prod"                               # 환경 이름 태그 / Environment tag
    Owner       = "team-prod"                          # 소유자 태그 / Owner tag
  }
}