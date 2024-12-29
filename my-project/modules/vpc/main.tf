# VPC 생성 / Create VPC
# 지정된 CIDR 블록을 기반으로 VPC를 생성합니다.
# Creates a VPC based on the specified CIDR block.
resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.name}-vpc"
    Environment = var.environment
  }
}

# 퍼블릭 서브넷 / Public Subnets
# VPC에 퍼블릭 서브넷을 생성합니다.
# Creates public subnets in the VPC.
resource "aws_subnet" "public" {
  count                  = 3
  vpc_id                 = aws_vpc.main.id
  cidr_block             = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone      = "${var.region}${var.azs[count.index]}"

  tags = {
    Name                         = "${var.name}-public-${count.index + 1}"
    Environment                  = var.environment
    "kubernetes.io/role/elb"     = "1"
  }
}

# 프라이빗 서브넷 / Private Subnets
# VPC에 프라이빗 서브넷을 생성합니다.
# Creates private subnets in the VPC.
resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = "${var.region}${var.azs[count.index]}"

  tags = {
    Name                              = "${var.name}-private-${count.index + 1}"
    Environment                       = var.environment
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# Attach 서브넷 / Attach Subnets
# VPC에 Attach 서브넷을 생성합니다.
# Creates attach subnets in the VPC.
resource "aws_subnet" "attach" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.attach_subnet_cidrs[count.index]
  availability_zone = "${var.region}${var.azs[count.index]}"

  tags = {
    Name        = "${var.name}-attach-${count.index + 1}"
    Environment = var.environment
  }
}

# DB 서브넷 / DB Subnets
# VPC에 DB 서브넷을 생성합니다.
# Creates DB subnets in the VPC.
resource "aws_subnet" "db" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_cidrs[count.index]
  availability_zone = "${var.region}${var.azs[count.index]}"

  tags = {
    Name        = "${var.name}-db-${count.index + 1}"
    Environment = var.environment
  }
}

# ElastiCache 서브넷 / ElastiCache Subnets
# VPC에 ElastiCache 서브넷을 생성합니다.
# Creates ElastiCache subnets in the VPC.
resource "aws_subnet" "elasticache" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.elasticache_subnet_cidrs[count.index]
  availability_zone = "${var.region}${var.azs[count.index]}"

  tags = {
    Name        = "${var.name}-elasticache-${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name        = "${var.name}-nat-gateway"
    Environment = var.environment
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name        = "${var.name}-nat-eip"
    Environment = var.environment
  }
}