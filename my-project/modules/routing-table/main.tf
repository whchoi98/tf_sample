# Internet Gateway 생성
resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id
  tags   = {
    Name        = "${var.name}-igw"
    Environment = var.environment
  }
}

# NAT Gateway 생성
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name        = "${var.name}-nat-eip"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_ids[0] # A Zone의 Public Subnet 사용
  tags          = {
    Name        = "${var.name}-nat-gateway"
    Environment = var.environment
  }
}

# 퍼블릭 서브넷별 Route Table 및 라우팅 설정
resource "aws_route_table" "public" {
  count  = length(var.public_subnet_ids)
  vpc_id = var.vpc_id
  tags = {
    Name        = "${var.name}-public-rt-${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_route" "public_route" {
  count                 = length(var.public_subnet_ids)
  route_table_id        = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id            = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public[count.index].id
}

# 프라이빗 서브넷별 Route Table 및 라우팅 설정
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_ids)
  vpc_id = var.vpc_id
  tags = {
    Name        = "${var.name}-private-rt-${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_route" "private_route" {
  count                 = length(var.private_subnet_ids)
  route_table_id        = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private[count.index].id
}

# Attach 서브넷별 Route Table 및 기본 라우팅 설정 (필요에 따라 변경 가능)
resource "aws_route_table" "attach" {
  count  = length(var.attach_subnet_ids)
  vpc_id = var.vpc_id
  tags = {
    Name        = "${var.name}-attach-rt-${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "attach" {
  count          = length(var.attach_subnet_ids)
  subnet_id      = var.attach_subnet_ids[count.index]
  route_table_id = aws_route_table.attach[count.index].id
}