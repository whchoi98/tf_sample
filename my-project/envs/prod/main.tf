# VPC 모듈 호출 / Call the VPC module
# VPC와 관련된 리소스를 생성합니다. / Creates resources related to VPC.
module "vpc" {
  source              = "../../modules/vpc"
  name                = "prod"                     # VPC 이름 / VPC name
  environment         = "production"              # 환경 이름 / Environment name
  region              = "ap-northeast-2"          # AWS 리전 / AWS Region
  azs                 = ["a", "b", "c"]           # 가용 영역 / Availability Zones
  cidr                = "10.0.0.0/16"             # VPC CIDR 블록 / VPC CIDR block

  # 퍼블릭 서브넷 CIDR 목록 / List of public subnet CIDRs
  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  # 프라이빗 서브넷 CIDR 목록 / List of private subnet CIDRs
  private_subnet_cidrs = [
    "10.0.32.0/19",
    "10.0.64.0/19",
    "10.0.96.0/19"
  ]

  # 어태치 서브넷 CIDR 목록 / List of attach subnet CIDRs
  attach_subnet_cidrs = [
    "10.0.241.0/24",
    "10.0.242.0/24",
    "10.0.243.0/24"
  ]
}

# 라우팅 테이블 모듈 호출 / Call the Routing Table module
# 서브넷별 라우팅 테이블을 생성하고 연결합니다. / Creates and associates routing tables for each subnet.
module "routing" {
  source              = "../../modules/routing-table"
  name                = "prod"                   # 라우팅 테이블 이름 / Routing Table name
  environment         = "production"            # 환경 이름 / Environment name
  vpc_id              = module.vpc.vpc_id       # VPC ID
  public_subnet_ids   = module.vpc.public_subnet_ids  # 퍼블릭 서브넷 ID / Public subnet IDs
  private_subnet_ids  = module.vpc.private_subnet_ids # 프라이빗 서브넷 ID / Private subnet IDs
  attach_subnet_ids   = module.vpc.attach_subnet_ids  # 어태치 서브넷 ID / Attach subnet IDs
}

# 보안 그룹 모듈 호출 / Call the Security Group module
# Security Group 리소스는 VPC Endpoint와 함께 사용됩니다. / Security groups are used with VPC Endpoints.
module "security_groups" {
  source      = "../../modules/security-group"
  vpc_id      = module.vpc.vpc_id             # VPC 모듈의 출력값 참조 / Refer output of VPC module
  environment = var.environment               # 환경 이름 / Environment name
  common_tags = var.common_tags               # 공통 태그 / Common tags
}


# VPC Endpoint 모듈 호출 / Call the VPC Endpoint module
# SSM 및 SSM Messages VPC Endpoint를 생성합니다. / Creates SSM and SSM Messages VPC Endpoints.
module "vpc_endpoints" {
  source              = "../../modules/vpc-endpoint"
  vpc_id              = module.vpc.vpc_id             # VPC 모듈 출력값 참조 / Refer VPC module output
  region              = var.region                     # AWS 리전 / AWS Region
  private_subnet_ids  = module.vpc.private_subnet_ids  # VPC 모듈의 프라이빗 서브넷 출력 참조 / Refer private subnets from VPC module
  ssm_security_group_id = module.security_groups.ssm_security_group_id  # SSM 보안 그룹 ID / SSM security group ID
  environment         = var.environment                # 환경 이름 / Environment name
  common_tags         = var.common_tags                # 공통 태그 / Common tags
}

# IAM 역할 모듈 호출 / Call the IAM Roles module
# EC2 인스턴스용 IAM 역할을 생성합니다.
# Creates IAM roles for EC2 instances.
module "iam_roles" {
  source      = "../../modules/iam/roles" # IAM 역할 모듈 경로 / Path to the IAM roles module
  name        = "prod"                    # IAM 역할 이름 / IAM role name
  environment = var.environment           # 환경 이름 / Environment name
  common_tags = var.common_tags           # 공통 태그 / Common tags
}

# SSM 인스턴스 프로파일 출력 / Output the SSM Instance Profile Name
# EC2에서 사용할 IAM Instance Profile의 이름을 출력합니다.
# Outputs the name of the IAM Instance Profile for EC2.
output "ssm_instance_profile_name" {
  description = "Name of the SSM Instance Profile" # SSM 인스턴스 프로파일의 이름
  value       = module.iam_roles.ssm_instance_profile_name # SSM Instance Profile Name
}

# SSM 역할 ARN 출력 / Output the SSM Role ARN
# 생성된 SSM IAM 역할의 ARN을 출력합니다.
# Outputs the ARN of the created SSM IAM role.
output "ssm_role_arn" {
  description = "ARN of the SSM Role" # SSM 역할의 ARN
  value       = module.iam_roles.ssm_role_arn # SSM Role ARN
}


# 최신 Amazon Linux 2 AMI 데이터 호출 / Fetch the latest Amazon Linux 2 AMI data
data "aws_ami" "amazon_linux_2" {
  most_recent = true                             # 가장 최근 AMI 선택 / Select the most recent AMI
  owners      = ["amazon"]                      # Amazon 소유 AMI / AMIs owned by Amazon

  # AMI 이름 필터 / AMI name filter
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# EC2 모듈 호출 / Call the EC2 module
module "ec2" {
  source                  = "../../modules/ec2"
  ami_id                  = data.aws_ami.amazon_linux_2.id  # Amazon Linux 2 AMI ID
  instance_type           = "t3.small"                     # EC2 인스턴스 타입 / EC2 instance type

  # 퍼블릭 서브넷 ID 및 고정 IP / Public subnet IDs and fixed IPs
  public_subnet_ids       = module.vpc.public_subnet_ids    # VPC 모듈에서 퍼블릭 서브넷 ID 참조 / Refer public subnet IDs from VPC module
  public_fixed_ips        = [
    # Public Subnet 1
    "10.0.1.111", "10.0.1.112",
    # Public Subnet 2
    "10.0.2.111", "10.0.2.112",
    # Public Subnet 3
    "10.0.3.111", "10.0.3.112"
  ]

  # 프라이빗 서브넷 ID 및 고정 IP / Private subnet IDs and fixed IPs
  private_subnet_ids      = module.vpc.private_subnet_ids   # VPC 모듈에서 프라이빗 서브넷 ID 참조 / Refer private subnet IDs from VPC module
  private_fixed_ips       = [
    # Private Subnet 1
    "10.0.32.111", "10.0.32.112",
    # Private Subnet 2
    "10.0.64.111", "10.0.64.112",
    # Private Subnet 3
    "10.0.96.111", "10.0.96.112"
  ]

  # IAM Instance Profile 이름을 iam_roles 모듈 출력값으로 지정 / Specify IAM Instance Profile name from iam_roles module output
  instance_profile        = module.iam_roles.ssm_instance_profile_name # 이름 전달

  # 보안 그룹 ID / Security Group IDs
  public_ec2_security_group_id  = module.security_groups.public_ec2_security_group_id  # 퍼블릭 보안 그룹 / Public security group
  private_ec2_security_group_id = module.security_groups.private_ec2_security_group_id # 프라이빗 보안 그룹 / Private security group

  # 환경 및 태그 / Environment and Tags
  environment             = var.environment            # 환경 이름 / Environment name
  common_tags             = var.common_tags            # 공통 태그 / Common tags
}




# ALB 모듈 호출 / Call the ALB module
# ALB 및 관련 리소스를 생성합니다. / Creates the ALB and related resources.
module "alb" {
  source                = "../../modules/alb"
  stack_name            = var.stack_name           # 스택 이름 / Stack name
  vpc_id                = module.vpc.vpc_id        # VPC 모듈 출력값 참조 / Refer VPC module output
  public_subnets        = module.vpc.public_subnet_ids  # VPC 모듈의 퍼블릭 서브넷 출력 참조 / Refer public subnets from VPC module
  alb_security_group_id = module.security_groups.alb_security_group_id  # ALB 보안 그룹 ID / ALB security group ID

  # 모든 프라이빗 EC2 인스턴스 ID를 전달 / Pass all private EC2 instance IDs
  private_instance_ids  = module.ec2.private_instance_ids

  common_tags           = var.common_tags
}

# NLB 모듈 호출 / Call the NLB module
# NLB 및 관련 리소스를 생성합니다. / Creates the NLB and related resources.
module "nlb" {
  source                   = "../../modules/nlb"
  stack_name               = var.stack_name           # 스택 이름 / Stack name
  vpc_id                   = module.vpc.vpc_id        # VPC 모듈 출력값 참조 / Refer VPC module output
  public_subnets           = module.vpc.public_subnet_ids  # VPC 모듈의 퍼블릭 서브넷 출력 참조 / Refer public subnets from VPC module
  private_subnets          = module.vpc.private_subnet_ids # VPC 모듈의 프라이빗 서브넷 출력 참조 / Refer private subnets from VPC module
  nlb_security_group_id    = module.security_groups.nlb_security_group_id  # NLB 보안 그룹 ID / NLB security group ID
  private_instance_1_id    = module.ec2.private_instance_1_id  # 프라이빗 인스턴스 1 ID / Private instance 1 ID
  private_instance_2_id    = module.ec2.private_instance_2_id  # 프라이빗 인스턴스 2 ID / Private instance 2 ID
  common_tags              = var.common_tags           # 공통 태그 / Common tags
}