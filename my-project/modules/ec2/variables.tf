variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EC2 instances"
  type        = list(string)
}

variable "fixed_ips" {
  description = "List of fixed IPs for EC2 instances"
  type        = list(string)
}

variable "key_pair" {
  description = "Key pair name for EC2 instances"
  type        = string
}

variable "instance_profile" {
  description = "IAM instance profile for EC2 instances"
  type        = string
}

variable "security_group_id" {
  description = "Security group for EC2 instances"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "subnet_type" {
  description = "Type of subnet (public or private)"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}