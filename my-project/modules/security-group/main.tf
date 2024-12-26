# SSM 보안 그룹 / SSM Security Group
resource "aws_security_group" "ssm" {
  name        = "${var.environment}-SSMSG"
  description = "Open-up ports for HTTP/S from all network"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound 모든 트래픽 허용 / Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # 모든 프로토콜 허용 / Allow all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-SSMSG"
    }
  )
}

# ALB 보안 그룹 / ALB Security Group
resource "aws_security_group" "alb" {
  name        = "${var.environment}-ALB-SG"
  description = "Open-up ports for HTTP/S from all network"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound 모든 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-ALB-SG"
    }
  )
}

# NLB 보안 그룹 / NLB Security Group
resource "aws_security_group" "nlb" {
  name        = "${var.environment}-NLB-SG"
  description = "Open-up ports for HTTP/S from all network"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound 모든 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-NLB-SG"
    }
  )
}

# 퍼블릭 EC2 보안 그룹 / Public EC2 Security Group
resource "aws_security_group" "public_ec2" {
  name        = "${var.environment}-PublicSG"
  description = "Open-up ports for ICMP, SSH, HTTP/S from all network"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound 모든 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-PublicSG"
    }
  )
}

# 프라이빗 EC2 보안 그룹 / Private EC2 Security Group
resource "aws_security_group" "private_ec2" {
  name        = "${var.environment}-PrivateSG"
  description = "Open-up ports for ICMP, SSH, HTTP/S from all network"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound 모든 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-PrivateSG"
    }
  )
}

# Aurora 보안 그룹 / Aurora Security Group
resource "aws_security_group" "aurora" {
  name        = "${var.environment}-Aurora-SG"
  description = "Allow inbound MySQL/Aurora traffic"
  vpc_id      = var.vpc_id

  # Aurora/MySQL 포트 허용 / Allow Aurora/MySQL port
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound 모든 트래픽 허용 / Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-Aurora-SG"
    }
  )
}

# ElastiCache 보안 그룹 / ElastiCache Security Group
resource "aws_security_group" "elasticache" {
  name        = "${var.environment}-ElastiCache-SG"
  description = "Allow inbound traffic for ElastiCache Redis or Memcached"
  vpc_id      = var.vpc_id

  # Redis 포트 허용 / Allow Redis port
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Memcached 포트 허용 (필요 시 활성화) / Allow Memcached port (uncomment if needed)
  # ingress {
  #   from_port   = 11211
  #   to_port     = 11211
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # Outbound 모든 트래픽 허용 / Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-ElastiCache-SG"
    }
  )
}