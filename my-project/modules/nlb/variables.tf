# 스택 이름 변수 / Stack Name Variable
# 스택의 이름을 정의합니다.
# Defines the name of the stack.
variable "stack_name" {
  description = "The name of the stack" # 스택 이름
  type        = string                 # 문자열 타입 / String type
}

# VPC ID 변수 / VPC ID Variable
# NLB가 연결될 VPC의 ID를 정의합니다.
# Defines the VPC ID to which the NLB will be attached.
variable "vpc_id" {
  description = "VPC ID" # VPC ID
  type        = string   # 문자열 타입 / String type
}

# 퍼블릭 서브넷 변수 / Public Subnets Variable
# NLB가 배치될 퍼블릭 서브넷 목록을 정의합니다.
# Defines the list of public subnets where the NLB will be deployed.
variable "public_subnets" {
  description = "List of public subnets" # 퍼블릭 서브넷 목록
  type        = list(string)             # 문자열 리스트 타입 / List of strings
}

# 프라이빗 서브넷 변수 / Private Subnets Variable
# NLB가 트래픽을 전달할 프라이빗 서브넷 목록을 정의합니다.
# Defines the list of private subnets where the NLB will forward traffic.
variable "private_subnets" {
  description = "List of private subnets" # 프라이빗 서브넷 목록
  type        = list(string)              # 문자열 리스트 타입 / List of strings
}

# NLB 보안 그룹 ID 변수 / NLB Security Group ID Variable
# NLB에 적용할 보안 그룹 ID를 정의합니다.
# Defines the security group ID to be applied to the NLB.
variable "nlb_security_group_id" {
  description = "Security group ID for NLB" # NLB 보안 그룹 ID
  type        = string                     # 문자열 타입 / String type
}

variable "private_instance_ids" {
  description = "List of private EC2 instance IDs to register with the NLB target group"
  type        = list(string)
}

# 공통 태그 변수 / Common Tags Variable
# 모든 리소스에 적용할 공통 태그를 정의합니다.
# Defines common tags applied to all resources.
variable "common_tags" {
  description = "Common tags for all resources" # 모든 리소스에 적용되는 공통 태그
  type        = map(string)                    # 문자열 맵 타입 / Map of strings
}