# 스택 이름 변수 / Stack name variable
# 리소스 그룹에 사용할 스택 이름을 정의합니다.
variable "stack_name" {
  description = "The name of the stack used for grouping resources." # 스택 이름
  type        = string                                              # 문자열 타입
}

# VPC ID 변수 / VPC ID variable
# ALB가 연결될 VPC의 ID를 정의합니다.
variable "vpc_id" {
  description = "The VPC ID where the ALB and related resources will be deployed." # VPC ID
  type        = string                                                           # 문자열 타입
}

# 퍼블릭 서브넷 변수 / Public subnets variable
# ALB가 배치될 퍼블릭 서브넷 목록을 정의합니다.
variable "public_subnets" {
  description = "List of public subnet IDs where the ALB will be deployed." # 퍼블릭 서브넷 목록
  type        = list(string)                                               # 문자열 리스트 타입
}

# ALB 보안 그룹 ID 변수 / ALB Security Group ID variable
# ALB에 적용할 보안 그룹의 ID를 정의합니다.
variable "alb_security_group_id" {
  description = "The security group ID to be applied to the ALB." # ALB 보안 그룹 ID
  type        = string                                           # 문자열 타입
}

# 프라이빗 EC2 인스턴스 ID 목록 변수 / Private EC2 instance IDs variable
# ALB 타겟 그룹에 등록될 EC2 인스턴스의 ID 목록을 정의합니다.
variable "private_instance_ids" {
  description = "List of private EC2 instance IDs to register with the ALB target group"
  type        = list(string)
}

# 공통 태그 변수 / Common tags variable
# 모든 리소스에 적용할 공통 태그를 정의합니다.
variable "common_tags" {
  description = "Common tags applied to all resources for consistent metadata." # 공통 태그
  type        = map(string)                                                     # 문자열 맵 타입
  default     = {                                                               # 기본값
    Environment = "prod"                                                        # 환경 이름 태그
    Owner       = "team-prod"                                                   # 소유자 태그
  }
}