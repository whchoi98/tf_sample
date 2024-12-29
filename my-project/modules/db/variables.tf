# Name Prefix for Resources
variable "name" {
  description = "The name prefix for the Aurora resources"
  type        = string
}

# Common Tags
variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

# DB Engine Version
variable "engine_version" {
  description = "The engine version of Aurora MySQL"
  type        = string
  default     = "5.7.mysql_aurora.2.11.2" # Example version
}

# Database Name
variable "database_name" {
  description = "The name of the default database in the Aurora cluster"
  type        = string
}

# Master Username
variable "master_username" {
  description = "The master username for the Aurora cluster"
  type        = string
}

# Backup Retention Period
variable "backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
  default     = 7
}

# Preferred Backup Window
variable "preferred_backup_window" {
  description = "The preferred backup window for the Aurora cluster"
  type        = string
  default     = "07:00-09:00"
}

# DB Subnet IDs
variable "db_subnet_ids" {
  description = "The list of subnet IDs for the Aurora DB subnet group"
  type        = list(string)
}

# VPC Security Group IDs
variable "vpc_security_group_ids" {
  description = "The list of VPC security group IDs for the Aurora cluster"
  type        = list(string)
}

# Instance Count
variable "instance_count" {
  description = "The number of Aurora DB instances"
  type        = number
  default     = 3
}

# Instance Class
variable "instance_class" {
  description = "The instance class for the Aurora DB instances"
  type        = string
  default     = "db.r5.large"
}

# Publicly Accessible
variable "publicly_accessible" {
  description = "Whether the Aurora DB instances are publicly accessible"
  type        = bool
  default     = false
}

# DB Subnet Group Name
variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

# Aurora 데이터베이스 마스터 비밀번호 / Aurora Database Master Password
# Aurora 클러스터의 마스터 비밀번호를 설정합니다.
# Sets the master password for the Aurora database cluster.
variable "master_password" {
  description = "The master password for the Aurora database" # Aurora 데이터베이스 마스터 비밀번호
  type        = string                                        # 문자열 타입 / String type
  sensitive   = true                                          # 출력 시 숨김 처리 / Hide value in output
}