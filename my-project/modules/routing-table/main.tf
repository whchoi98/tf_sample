# 퍼블릭 서브넷별 Route Table 및 라우팅 설정 / Public Subnet Route Table and Routing
# 퍼블릭 서브넷에 Route Table을 생성하고, 인터넷 게이트웨이를 통해 트래픽을 라우팅합니다.
# Creates Route Tables for Public Subnets and routes traffic through the Internet Gateway.

# 퍼블릭 Route Table 생성 / Create Public Route Tables
resource "aws_route_table" "public" {
  count  = length(var.public_subnet_ids) # 퍼블릭 서브넷 개수만큼 Route Table 생성 / Creates Route Tables for each Public Subnet
  vpc_id = var.vpc_id                    # 연결된 VPC ID / Associated VPC ID
  tags = {
    Name        = "${var.name}-public-rt-${count.index + 1}" # Route Table 이름 태그 / Route Table name tag
    Environment = var.environment                           # 환경 태그 / Environment tag
  }
}

# 퍼블릭 서브넷에 대한 라우팅 설정 / Configure Routing for Public Subnets
resource "aws_route" "public_route" {
  count                 = length(var.public_subnet_ids)  # 퍼블릭 서브넷 개수만큼 라우트 생성 / Creates routes for each Public Subnet
  route_table_id        = aws_route_table.public[count.index].id # 연결된 Route Table ID / Associated Route Table ID
  destination_cidr_block = "0.0.0.0/0"                   # 기본 라우트 (인터넷으로 트래픽 전달) / Default route (traffic to the internet)
  gateway_id            = var.internet_gateway_id   # 인터넷 게이트웨이 ID / Internet Gateway ID
}

# 퍼블릭 서브넷에 Route Table 연결 / Associate Route Tables with Public Subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_ids) # 퍼블릭 서브넷 개수만큼 연결 생성 / Creates associations for each Public Subnet
  subnet_id      = var.public_subnet_ids[count.index] # 퍼블릭 서브넷 ID / Public Subnet ID
  route_table_id = aws_route_table.public[count.index].id # 연결된 Route Table ID / Associated Route Table ID
}

# 프라이빗 서브넷별 Route Table 및 라우팅 설정 / Private Subnet Route Table and Routing
# 프라이빗 서브넷에 Route Table을 생성하고, NAT 게이트웨이를 통해 트래픽을 라우팅합니다.
# Creates Route Tables for Private Subnets and routes traffic through the NAT Gateway.

# 프라이빗 Route Table 생성 / Create Private Route Tables
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_ids) # 프라이빗 서브넷 개수만큼 Route Table 생성 / Creates Route Tables for each Private Subnet
  vpc_id = var.vpc_id                     # 연결된 VPC ID / Associated VPC ID
  tags = {
    Name        = "${var.name}-private-rt-${count.index + 1}" # Route Table 이름 태그 / Route Table name tag
    Environment = var.environment                            # 환경 태그 / Environment tag
  }
}

# 프라이빗 서브넷에 대한 라우팅 설정 / Configure Routing for Private Subnets
resource "aws_route" "private_route" {
  count                 = length(var.private_subnet_ids)  # 프라이빗 서브넷 개수만큼 라우트 생성 / Creates routes for each Private Subnet
  route_table_id        = aws_route_table.private[count.index].id # 연결된 Route Table ID / Associated Route Table ID
  destination_cidr_block = "0.0.0.0/0"                   # 기본 라우트 (NAT Gateway로 트래픽 전달) / Default route (traffic to NAT Gateway)
  gateway_id            = var.gateway_id       # NAT 게이트웨이 ID / NAT Gateway ID
}

# 프라이빗 서브넷에 Route Table 연결 / Associate Route Tables with Private Subnets
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_ids) # 프라이빗 서브넷 개수만큼 연결 생성 / Creates associations for each Private Subnet
  subnet_id      = var.private_subnet_ids[count.index] # 프라이빗 서브넷 ID / Private Subnet ID
  route_table_id = aws_route_table.private[count.index].id # 연결된 Route Table ID / Associated Route Table ID
}

# Attach 서브넷별 Route Table 및 기본 라우팅 설정 / Attach Subnet Route Table and Default Routing
# Attach 서브넷에 Route Table을 생성하고 연결합니다 (필요에 따라 변경 가능).
# Creates and associates Route Tables for Attach Subnets (modifiable if needed).

# Attach Route Table 생성 / Create Attach Route Tables
resource "aws_route_table" "attach" {
  count  = length(var.attach_subnet_ids) # Attach 서브넷 개수만큼 Route Table 생성 / Creates Route Tables for each Attach Subnet
  vpc_id = var.vpc_id                    # 연결된 VPC ID / Associated VPC ID
  tags = {
    Name        = "${var.name}-attach-rt-${count.index + 1}" # Route Table 이름 태그 / Route Table name tag
    Environment = var.environment                           # 환경 태그 / Environment tag
  }
}

# Attach 서브넷에 Route Table 연결 / Associate Route Tables with Attach Subnets
resource "aws_route_table_association" "attach" {
  count          = length(var.attach_subnet_ids) # Attach 서브넷 개수만큼 연결 생성 / Creates associations for each Attach Subnet
  subnet_id      = var.attach_subnet_ids[count.index] # Attach 서브넷 ID / Attach Subnet ID
  route_table_id = aws_route_table.attach[count.index].id # 연결된 Route Table ID / Associated Route Table ID
}

# DB Route Table 및 라우팅 설정 / DB Route Table and Routing
# DB 서브넷에 Route Table을 생성하고 NAT Gateway를 통해 인터넷 트래픽을 라우팅합니다.
# Creates Route Tables for DB Subnets and routes traffic through the NAT Gateway.

# DB Route Table 생성 / Create DB Route Tables
resource "aws_route_table" "db" {
  count  = length(var.db_subnet_ids)  # DB 서브넷 개수만큼 Route Table 생성 / Creates Route Tables for each DB Subnet
  vpc_id = var.vpc_id                # 연결된 VPC ID / Associated VPC ID

  tags = {
    Name        = "${var.name}-db-rt-${count.index + 1}" # Route Table 이름 태그 / Route Table name tag
    Environment = var.environment                       # 환경 태그 / Environment tag
  }
}

# DB 서브넷에 대한 라우팅 설정 / Configure Routing for DB Subnets
resource "aws_route" "db_route" {
  count                 = length(var.db_subnet_ids)  # DB 서브넷 개수만큼 라우트 생성 / Creates routes for each DB Subnet
  route_table_id        = aws_route_table.db[count.index].id # 연결된 Route Table ID / Associated Route Table ID
  destination_cidr_block = "0.0.0.0/0"                   # 기본 라우트 (NAT Gateway로 트래픽 전달) / Default route (traffic to NAT Gateway)
  nat_gateway_id         = aws_nat_gateway.main.id           # NAT 게이트웨이 ID / NAT Gateway ID
}

# DB 서브넷에 Route Table 연결 / Associate Route Tables with DB Subnets
resource "aws_route_table_association" "db" {
  count          = length(var.db_subnet_ids)  # DB 서브넷 개수만큼 연결 생성 / Creates associations for each DB Subnet
  subnet_id      = var.db_subnet_ids[count.index] # DB 서브넷 ID / DB Subnet ID
  route_table_id = aws_route_table.db[count.index].id # 연결된 Route Table ID / Associated Route Table ID
}

# ElastiCache Route Table 및 라우팅 설정 / ElastiCache Route Table and Routing
# ElastiCache 서브넷에 Route Table을 생성하고 NAT Gateway를 통해 인터넷 트래픽을 라우팅합니다.
# Creates Route Tables for ElastiCache Subnets and routes traffic through the NAT Gateway.

# ElastiCache Route Table 생성 / Create ElastiCache Route Tables
resource "aws_route_table" "elasticache" {
  count  = length(var.elasticache_subnet_ids)  # ElastiCache 서브넷 개수만큼 Route Table 생성 / Creates Route Tables for each ElastiCache Subnet
  vpc_id = var.vpc_id                         # 연결된 VPC ID / Associated VPC ID

  tags = {
    Name        = "${var.name}-elasticache-rt-${count.index + 1}" # Route Table 이름 태그 / Route Table name tag
    Environment = var.environment                                # 환경 태그 / Environment tag
  }
}

# ElastiCache 서브넷에 대한 라우팅 설정 / Configure Routing for ElastiCache Subnets
resource "aws_route" "elasticache_route" {
  count                 = length(var.elasticache_subnet_ids)  # ElastiCache 서브넷 개수만큼 라우트 생성 / Creates routes for each ElastiCache Subnet
  route_table_id        = aws_route_table.elasticache[count.index].id # 연결된 Route Table ID / Associated Route Table ID
  destination_cidr_block = "0.0.0.0/0"                        # 기본 라우트 (NAT Gateway로 트래픽 전달) / Default route (traffic to NAT Gateway)
  nat_gateway_id         = aws_nat_gateway.main.id                # NAT 게이트웨이 ID / NAT Gateway ID
}

# ElastiCache 서브넷에 Route Table 연결 / Associate Route Tables with ElastiCache Subnets
resource "aws_route_table_association" "elasticache" {
  count          = length(var.elasticache_subnet_ids)  # ElastiCache 서브넷 개수만큼 연결 생성 / Creates associations for each ElastiCache Subnet
  subnet_id      = var.elasticache_subnet_ids[count.index] # ElastiCache 서브넷 ID / ElastiCache Subnet ID
  route_table_id = aws_route_table.elasticache[count.index].id # 연결된 Route Table ID / Associated Route Table ID
}