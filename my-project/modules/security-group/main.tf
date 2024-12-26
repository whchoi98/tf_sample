# SSM 보안 그룹 / SSM Security Group
# SSM 트래픽을 허용하기 위해 HTTP와 HTTPS 포트를 열어주는 보안 그룹을 생성합니다.
# Creates a security group that allows HTTP and HTTPS traffic for SSM.
resource "aws_security_group" "ssm" {
  name        = "${var.environment}-SSMSG"        # 보안 그룹 이름 / Security group name
  description = "Open-up ports for HTTP/S from all network" # 보안 그룹 설명 / Security group description
  vpc_id      = var.vpc_id                        # 연결된 VPC ID / Associated VPC ID

  # HTTP 트래픽 허용 / Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # HTTPS 트래픽 허용 / Allow HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # 태그 설정 / Tag configuration
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-SSMSG"           # 리소스 이름 태그 / Resource name tag
    }
  )
}

# ALB 보안 그룹 / ALB Security Group
# ALB 트래픽을 허용하기 위해 HTTP와 HTTPS 포트를 열어주는 보안 그룹을 생성합니다.
# Creates a security group that allows HTTP and HTTPS traffic for ALB.
resource "aws_security_group" "alb" {
  name        = "${var.environment}-ALB-SG"       # 보안 그룹 이름 / Security group name
  description = "Open-up ports for HTTP/S from all network" # 보안 그룹 설명 / Security group description
  vpc_id      = var.vpc_id                        # 연결된 VPC ID / Associated VPC ID

  # HTTP 트래픽 허용 / Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # HTTPS 트래픽 허용 / Allow HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # 태그 설정 / Tag configuration
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-ALB-SG"          # 리소스 이름 태그 / Resource name tag
    }
  )
}

# NLB 보안 그룹 / NLB Security Group
# NLB 트래픽을 허용하기 위해 HTTP와 HTTPS 포트를 열어주는 보안 그룹을 생성합니다.
# Creates a security group that allows HTTP and HTTPS traffic for NLB.
resource "aws_security_group" "nlb" {
  name        = "${var.environment}-NLB-SG"       # 보안 그룹 이름 / Security group name
  description = "Open-up ports for HTTP/S from all network" # 보안 그룹 설명 / Security group description
  vpc_id      = var.vpc_id                        # 연결된 VPC ID / Associated VPC ID

  # HTTP 트래픽 허용 / Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # HTTPS 트래픽 허용 / Allow HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # 태그 설정 / Tag configuration
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-NLB-SG"          # 리소스 이름 태그 / Resource name tag
    }
  )
}

# 퍼블릭 EC2 보안 그룹 / Public EC2 Security Group
# 퍼블릭 EC2 트래픽을 허용하기 위해 ICMP, SSH, HTTP, HTTPS 포트를 열어주는 보안 그룹을 생성합니다.
# Creates a security group that allows ICMP, SSH, HTTP, and HTTPS traffic for public EC2 instances.
resource "aws_security_group" "public_ec2" {
  name        = "${var.environment}-PublicSG"     # 보안 그룹 이름 / Security group name
  description = "Open-up ports for ICMP, SSH, HTTP/S from all network" # 보안 그룹 설명 / Security group description
  vpc_id      = var.vpc_id                        # 연결된 VPC ID / Associated VPC ID

  # ICMP 트래픽 허용 / Allow ICMP traffic
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # SSH 트래픽 허용 / Allow SSH traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # HTTP 트래픽 허용 / Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # HTTPS 트래픽 허용 / Allow HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # 태그 설정 / Tag configuration
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-PublicSG"        # 리소스 이름 태그 / Resource name tag
    }
  )
}

# 프라이빗 EC2 보안 그룹 / Private EC2 Security Group
# 프라이빗 EC2 트래픽을 허용하기 위해 ICMP, SSH, HTTP, HTTPS 포트를 열어주는 보안 그룹을 생성합니다.
# Creates a security group that allows ICMP, SSH, HTTP, and HTTPS traffic for private EC2 instances.
resource "aws_security_group" "private_ec2" {
  name        = "${var.environment}-PrivateSG"    # 보안 그룹 이름 / Security group name
  description = "Open-up ports for ICMP, SSH, HTTP/S from all network" # 보안 그룹 설명 / Security group description
  vpc_id      = var.vpc_id                        # 연결된 VPC ID / Associated VPC ID

  # ICMP 트래픽 허용 / Allow ICMP traffic
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # SSH 트래픽 허용 / Allow SSH traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # HTTP 트래픽 허용 / Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # HTTPS 트래픽 허용 / Allow HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                   # 모든 네트워크 허용 / Allow all networks
  }

  # 태그 설정 / Tag configuration
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-PrivateSG"       # 리소스 이름 태그 / Resource name tag
    }
  )
}