module "vpc" {
  source              = "../../modules/vpc"
  name                = "prod"
  environment         = "production"
  region              = "ap-northeast-2"
  azs                 = ["a", "b", "c"]
  cidr                = "10.0.0.0/16"

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.32.0/19",
    "10.0.64.0/19",
    "10.0.96.0/19"
  ]

  attach_subnet_cidrs = [
    "10.0.241.0/24",
    "10.0.242.0/24",
    "10.0.243.0/24"
  ]
}

module "routing" {
  source              = "../../modules/routing-table"
  name                = "prod"
  environment         = "production"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids
  attach_subnet_ids   = module.vpc.attach_subnet_ids
}

module "ec2" {
  source           = "../../modules/ec2"
  ami_id           = data.aws_ami.amazon_linux_2.id
  instance_type    = "t3.small"
  public_subnet_ids = var.public_subnet_ids
  private_subnet_ids = var.private_subnet_ids
  public_fixed_ips  = [
    "10.0.32.101", "10.0.32.102", # Private Subnet 1
    "10.0.64.101", "10.0.64.102", # Private Subnet 2
    "10.0.96.101", "10.0.96.102"  # Private Subnet 3
  ]
  private_fixed_ips = [
    "10.0.32.101", "10.0.32.102", # Private Subnet 1
    "10.0.64.101", "10.0.64.102", # Private Subnet 2
    "10.0.96.101", "10.0.96.102"  # Private Subnet 3
  ]
  instance_profile = var.instance_profile
  public_ec2_security_group_id  = module.security_groups.public_ec2_security_group_id
  private_ec2_security_group_id = module.security_groups.private_ec2_security_group_id
  environment      = var.environment
  common_tags      = var.common_tags
}

module "iam_roles" {
  source      = "../../modules/iam/roles"
  name        = "prod"
  environment = var.environment
  common_tags = var.common_tags
}

# Security Group 모듈 호출 / Call the Security Group module
# Security Group 리소스는 VPC Endpoint와 함께 사용됩니다. / Security Groups are used with VPC Endpoints.
module "security_groups" {
  source      = "../../modules/security-group"
  vpc_id      = var.vpc_id
  environment = var.environment
  common_tags = var.common_tags
}

# VPC Endpoint 모듈 호출 / Call the VPC Endpoint module
# SSM 및 SSM Messages VPC Endpoint를 생성합니다. / Create SSM and SSM Messages VPC Endpoints.
module "vpc_endpoints" {
  source              = "../../modules/vpc-endpoint"
  
  # VPC ID 및 AWS 리전 정보 / VPC ID and AWS Region
  vpc_id              = var.vpc_id
  region              = var.region
  
  # Private Subnet ID 목록 / List of Private Subnet IDs
  private_subnet_ids  = var.private_subnet_ids
  
  # Security Group ID (SSMSG) / Security Group ID (SSMSG)
  ssm_security_group_id = module.security_groups.ssm_security_group_id
  
  # 환경 정보 및 공통 태그 / Environment information and common tags
  environment         = var.environment
  common_tags         = var.common_tags
}

module "alb" {
  source = "../../modules/alb"

  # 필수 변수 전달
  stack_name               = var.stack_name
  vpc_id                   = var.vpc_id
  public_subnets           = var.public_subnets
  alb_security_group_id    = module.security_groups.alb_security_group_id
  private_instance_1_id    = module.ec2.private_instance_1_id
  private_instance_2_id    = module.ec2.private_instance_2_id
  common_tags              = var.common_tags
}

module "nlb" {
  source = "../../modules/nlb"

  # 필수 변수 전달
  stack_name               = var.stack_name
  vpc_id                   = var.vpc_id
  public_subnets           = var.public_subnets
  private_subnets          = var.private_subnets
  nlb_security_group_id    = module.security_groups.nlb_security_group_id
  private_instance_1_id    = module.ec2.private_instance_1_id
  private_instance_2_id    = module.ec2.private_instance_2_id
  common_tags              = var.common_tags
}