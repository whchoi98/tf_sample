# 리소스 이름 접두사 / Name Prefix for Resources
# Aurora 리소스에 사용할 이름 접두사를 정의합니다.
# Defines the name prefix for Aurora resources.
variable "name" {
  description = "The name prefix for the Aurora resources" # Aurora 리소스 이름 접두사
  type        = string                                    # 문자열 타입 / String type
}

# 공통 태그 / Common Tags
# 모든 리소스에 적용할 공통 태그를 정의합니다.
# Defines common tags applied to all resources.
variable "common_tags" {
  description = "Common tags applied to all resources" # 공통 태그
  type        = map(string)                            # 문자열 맵 타입 / Map of strings
  default     = {}                                     # 기본값 / Default: 빈 맵
}

# DB 엔진 버전 / DB Engine Version
# Aurora MySQL 엔진의 버전을 정의합니다.
# Defines the engine version of Aurora MySQL.
variable "engine_version" {
  description = "The engine version of Aurora MySQL" # Aurora MySQL 엔진 버전
  type        = string                               # 문자열 타입 / String type
  default     = "8.0.mysql_aurora.3.06.0"         # 기본 버전 / Default version
}

# 데이터베이스 이름 / Database Name
# Aurora 클러스터의 기본 데이터베이스 이름을 정의합니다.
# Defines the name of the default database in the Aurora cluster.
variable "database_name" {
  description = "The name of the default database in the Aurora cluster" # 기본 데이터베이스 이름
  type        = string                                                  # 문자열 타입 / String type
}

# 마스터 사용자 이름 / Master Username
# Aurora 클러스터의 마스터 사용자 이름을 정의합니다.
# Defines the master username for the Aurora cluster.
variable "master_username" {
  description = "The master username for the Aurora cluster" # Aurora 클러스터 마스터 사용자 이름
  type        = string                                      # 문자열 타입 / String type
}

# 백업 유지 기간 / Backup Retention Period
# 백업을 유지할 일 수를 정의합니다.
# Defines the number of days to retain backups.
variable "backup_retention_period" {
  description = "The number of days to retain backups" # 백업 유지 기간
  type        = number                                 # 숫자 타입 / Number type
  default     = 7                                     # 기본값: 7일 / Default: 7 days
}

# 백업 선호 시간대 / Preferred Backup Window
# Aurora 클러스터의 선호 백업 시간대를 정의합니다.
# Defines the preferred backup window for the Aurora cluster.
variable "preferred_backup_window" {
  description = "The preferred backup window for the Aurora cluster" # 백업 선호 시간대
  type        = string                                              # 문자열 타입 / String type
  default     = "07:00-09:00"                                       # 기본값 / Default value
}

# DB 서브넷 ID / DB Subnet IDs
# Aurora DB 서브넷 그룹에 사용할 서브넷 ID 목록을 정의합니다.
# Defines the list of subnet IDs for the Aurora DB subnet group.
variable "db_subnet_ids" {
  description = "The list of subnet IDs for the Aurora DB subnet group" # DB 서브넷 ID 목록
  type        = list(string)                                           # 문자열 리스트 타입 / List of strings
}

# VPC 보안 그룹 ID / VPC Security Group IDs
# Aurora 클러스터에 적용할 VPC 보안 그룹 ID 목록을 정의합니다.
# Defines the list of VPC security group IDs for the Aurora cluster.
variable "vpc_security_group_ids" {
  description = "The list of VPC security group IDs for the Aurora cluster" # VPC 보안 그룹 ID 목록
  type        = list(string)                                               # 문자열 리스트 타입 / List of strings
}

# 인스턴스 개수 / Instance Count
# Aurora 클러스터의 DB 인스턴스 개수를 정의합니다.
# Defines the number of Aurora DB instances.
variable "instance_count" {
  description = "The number of Aurora DB instances" # Aurora DB 인스턴스 개수
  type        = number                              # 숫자 타입 / Number type
  default     = 3                                   # 기본값: 3개 / Default: 3 instances
}

# 인스턴스 클래스 / Instance Class
# Aurora DB 인스턴스의 클래스를 정의합니다.
# Defines the instance class for the Aurora DB instances.
variable "instance_class" {
  description = "The instance class for the Aurora DB instances" # Aurora DB 인스턴스 클래스
  type        = string                                          # 문자열 타입 / String type
  default     = "db.r5.large"                                   # 기본값 / Default value
}

# 퍼블릭 액세스 가능 여부 / Publicly Accessible
# Aurora DB 인스턴스가 퍼블릭 액세스 가능한지 여부를 정의합니다.
# Defines whether the Aurora DB instances are publicly accessible.
variable "publicly_accessible" {
  description = "Whether the Aurora DB instances are publicly accessible" # 퍼블릭 액세스 가능 여부
  type        = bool                                                     # 불리언 타입 / Boolean type
  default     = false                                                    # 기본값: false / Default: false
}

# DB 서브넷 그룹 이름 / DB Subnet Group Name
# Aurora DB 서브넷 그룹 이름을 정의합니다.
# Defines the name of the DB subnet group.
variable "db_subnet_group_name" {
  description = "The name of the DB subnet group" # DB 서브넷 그룹 이름
  type        = string                           # 문자열 타입 / String type
}

# 마스터 비밀번호 / Master Password
# Aurora 클러스터의 마스터 비밀번호를 정의합니다.
# Defines the master password for the Aurora database cluster.
variable "master_password" {
  description = "The master password for the Aurora database" # Aurora 마스터 비밀번호
  type        = string                                        # 문자열 타입 / String type
  sensitive   = true                                          # 출력 시 숨김 처리 / Hide value in output
}