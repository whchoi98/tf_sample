variable "stack_name" {
  description = "The name of the stack"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "nlb_security_group_id" {
  description = "Security group ID for NLB"
  type        = string
}

variable "private_instance_1_id" {
  description = "Instance ID for private EC2 instance 1"
  type        = string
}

variable "private_instance_2_id" {
  description = "Instance ID for private EC2 instance 2"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}