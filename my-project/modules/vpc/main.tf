# VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.name}-vpc"
    Environment = var.environment
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = "${var.region}${var.azs[count.index]}"
  tags = {
    Name = "${var.name}-public-${count.index + 1}"
    Environment = var.environment
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = "${var.region}${var.azs[count.index]}"
  tags = {
    Name = "${var.name}-private-${count.index + 1}"
    Environment = var.environment
  }
}

# Attach Subnets
resource "aws_subnet" "attach" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.attach_subnet_cidrs[count.index]
  availability_zone = "${var.region}${var.azs[count.index]}"
  tags = {
    Name = "${var.name}-attach-${count.index + 1}"
    Environment = var.environment
  }
}