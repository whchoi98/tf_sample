variable "name" {
  description = "The name prefix for the VPC and subnets"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "azs" {
  description = "The availability zones to use"
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "attach_subnet_cidrs" {
  description = "CIDR blocks for attach subnets"
  type        = list(string)
}