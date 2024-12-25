variable "region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {
    Environment = "prod"
    Owner       = "team-prod"
  }
}
variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "stack_name" {
  description = "The name of the stack"
  type        = string
}

variable "instance_profile" {
  description = "IAM Instance Profile ARN"
  type        = string
}

