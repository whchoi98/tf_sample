variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
}

variable "key_pair" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_fixed_ips" {
  description = "List of fixed private IPs for Public Subnet EC2 instances"
  type        = list(string)
}

variable "private_fixed_ips" {
  description = "List of fixed private IPs for Private Subnet EC2 instances"
  type        = list(string)
}

variable "public_ec2_security_group_id" {
  description = "Security group ID for Public EC2 instances"
  type        = string
}

variable "private_ec2_security_group_id" {
  description = "Security group ID for Private EC2 instances"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}