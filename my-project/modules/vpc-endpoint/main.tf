# SSM VPC Endpoint
# 이 Endpoint는 EC2 인스턴스가 AWS Systems Manager (SSM) 서비스에 액세스할 수 있도록 구성됩니다.
# This Endpoint allows EC2 instances to access AWS Systems Manager (SSM) service.
resource "aws_vpc_endpoint" "ssm" {
  # VPC ID 지정 / Specify the VPC ID
  vpc_id            = var.vpc_id
  
  # SSM 서비스 이름 (리전별로 지정) / Specify the SSM service name (region-specific)
  service_name      = "com.amazonaws.${var.region}.ssm"
  
  # Interface 타입의 VPC Endpoint 생성 / Create an Interface type VPC Endpoint
  vpc_endpoint_type = "Interface"
  
  # Private DNS 활성화 / Enable Private DNS
  # (내부 도메인 이름으로 SSM 액세스 가능 / Allow access to SSM via internal domain names)
  private_dns_enabled = true

  # VPC Endpoint를 연결할 Private Subnet ID 목록 / List of Private Subnet IDs to associate with the VPC Endpoint
  subnet_ids = var.private_subnet_ids

  # VPC Endpoint와 연결할 Security Group / Security Group to associate with the VPC Endpoint
  security_group_ids = [var.ssm_security_group_id]

  # 태그 지정 / Specify tags
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-ssm-vpc-endpoint"
    }
  )
}

# SSM Messages VPC Endpoint
# 이 Endpoint는 EC2 인스턴스가 SSM Messages 서비스에 액세스할 수 있도록 구성됩니다.
# This Endpoint allows EC2 instances to access the SSM Messages service.
resource "aws_vpc_endpoint" "ssmmessages" {
  # VPC ID 지정 / Specify the VPC ID
  vpc_id            = var.vpc_id
  
  # SSM Messages 서비스 이름 (리전별로 지정) / Specify the SSM Messages service name (region-specific)
  service_name      = "com.amazonaws.${var.region}.ssmmessages"
  
  # Interface 타입의 VPC Endpoint 생성 / Create an Interface type VPC Endpoint
  vpc_endpoint_type = "Interface"
  
  # Private DNS 활성화 / Enable Private DNS
  # (내부 도메인 이름으로 SSM Messages 액세스 가능 / Allow access to SSM Messages via internal domain names)
  private_dns_enabled = true

  # VPC Endpoint를 연결할 Private Subnet ID 목록 / List of Private Subnet IDs to associate with the VPC Endpoint
  subnet_ids = var.private_subnet_ids

  # VPC Endpoint와 연결할 Security Group / Security Group to associate with the VPC Endpoint
  security_group_ids = [var.ssm_security_group_id]

  # 태그 지정 / Specify tags
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-ssmmessages-vpc-endpoint"
    }
  )
}