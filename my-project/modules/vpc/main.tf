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

# Internet Gateway 생성 / Create Internet Gateway
# VPC와 연결된 인터넷 게이트웨이를 생성합니다.
# Creates an Internet Gateway associated with the VPC.
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id # 연결된 VPC ID / Associated VPC ID
  tags   = {
    Name        = "${var.name}-igw"      # 인터넷 게이트웨이 이름 태그 / Internet Gateway name tag
    Environment = var.environment        # 환경 태그 / Environment tag
  }
}

# NAT Gateway 생성 / Create NAT Gateway
# A Zone의 Public Subnet을 사용하여 NAT 게이트웨이를 생성합니다.
# Creates a NAT Gateway using a Public Subnet in Zone A.
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id # NAT Gateway에 연결된 Elastic IP / Elastic IP associated with the NAT Gateway
  subnet_id     = aws_subnet.public[0].id # A Zone의 Public Subnet ID / Public Subnet ID in Zone A
  depends_on    = [aws_internet_gateway.main]
  tags          = {
    Name        = "${var.name}-nat-gateway" # NAT Gateway 이름 태그 / NAT Gateway name tag
    Environment = var.environment           # 환경 태그 / Environment tag
  }
}

# Elastic IP 생성 / Create Elastic IP
# NAT Gateway에 사용할 Elastic IP를 생성합니다.
# Creates an Elastic IP for the NAT Gateway.
resource "aws_eip" "nat" {
  domain = "vpc" # VPC 도메인 / VPC domain
  tags = {
    Name        = "${var.name}-nat-eip" # NAT EIP 이름 태그 / NAT EIP name tag
    Environment = var.environment       # 환경 태그 / Environment tag
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