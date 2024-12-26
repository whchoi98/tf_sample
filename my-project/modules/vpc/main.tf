# VPC 생성 / Create VPC
# 지정된 CIDR 블록을 기반으로 VPC를 생성합니다.
# Creates a VPC based on the specified CIDR block.
resource "aws_vpc" "main" {
  cidr_block           = var.cidr               # VPC의 CIDR 블록 / CIDR block of the VPC
  enable_dns_support   = true                   # DNS 지원 활성화 / Enable DNS support
  enable_dns_hostnames = true                   # DNS 호스트 이름 활성화 / Enable DNS hostnames

  # 태그 설정 / Tag configuration
  tags = {
    Name        = "${var.name}-vpc"             # VPC 이름 태그 / VPC name tag
    Environment = var.environment               # 환경 태그 / Environment tag
  }
}

# 퍼블릭 서브넷 / Public Subnets
# VPC에 퍼블릭 서브넷을 생성합니다.
# Creates public subnets in the VPC.
resource "aws_subnet" "public" {
  count                  = 3                     # 서브넷 수 / Number of subnets
  vpc_id                 = aws_vpc.main.id       # 연결된 VPC ID / Associated VPC ID
  cidr_block             = var.public_subnet_cidrs[count.index] # 퍼블릭 서브넷의 CIDR 블록 / CIDR block of public subnets
  map_public_ip_on_launch = true                 # 퍼블릭 IP 자동 할당 활성화 / Enable automatic public IP assignment
  availability_zone      = "${var.region}${var.azs[count.index]}" # 가용 영역 지정 / Specify availability zones

  # 태그 설정 / Tag configuration
  tags = {
    Name                         = "${var.name}-public-${count.index + 1}" # 서브넷 이름 태그 / Subnet name tag
    Environment                  = var.environment                        # 환경 태그 / Environment tag
    "kubernetes.io/role/elb"     = "1"                                    # EKS 퍼블릭 서브넷 태그 / EKS public subnet tag
  }
}

# 프라이빗 서브넷 / Private Subnets
# VPC에 프라이빗 서브넷을 생성합니다.
# Creates private subnets in the VPC.
resource "aws_subnet" "private" {
  count             = 3                      # 서브넷 수 / Number of subnets
  vpc_id            = aws_vpc.main.id        # 연결된 VPC ID / Associated VPC ID
  cidr_block        = var.private_subnet_cidrs[count.index] # 프라이빗 서브넷의 CIDR 블록 / CIDR block of private subnets
  availability_zone = "${var.region}${var.azs[count.index]}" # 가용 영역 지정 / Specify availability zones

  # 태그 설정 / Tag configuration
  tags = {
    Name                              = "${var.name}-private-${count.index + 1}" # 서브넷 이름 태그 / Subnet name tag
    Environment                       = var.environment                         # 환경 태그 / Environment tag
    "kubernetes.io/role/internal-elb" = "1"                                     # EKS 프라이빗 서브넷 태그 / EKS private subnet tag
  }
}

# Attach 서브넷 / Attach Subnets
# VPC에 Attach 서브넷을 생성합니다.
# Creates attach subnets in the VPC.
resource "aws_subnet" "attach" {
  count             = 3                      # 서브넷 수 / Number of subnets
  vpc_id            = aws_vpc.main.id        # 연결된 VPC ID / Associated VPC ID
  cidr_block        = var.attach_subnet_cidrs[count.index] # Attach 서브넷의 CIDR 블록 / CIDR block of attach subnets
  availability_zone = "${var.region}${var.azs[count.index]}" # 가용 영역 지정 / Specify availability zones

  # 태그 설정 / Tag configuration
  tags = {
    Name        = "${var.name}-attach-${count.index + 1}" # 서브넷 이름 태그 / Subnet name tag
    Environment = var.environment                        # 환경 태그 / Environment tag
  }
}