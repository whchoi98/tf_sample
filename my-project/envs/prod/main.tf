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
module "public_ec2" {
  source           = "../../modules/ec2"
  ami_id           = data.aws_ami.amazon_linux_2.id
  instance_type    = "t3.small"
  subnet_ids       = var.public_subnet_ids
  fixed_ips        = [
    "10.0.1.101", "10.0.1.102", # Public Subnet 1
    "10.0.2.101", "10.0.2.102", # Public Subnet 2
    "10.0.3.101", "10.0.3.102"  # Public Subnet 3
  ]
  key_pair         = var.key_pair
  instance_profile = var.instance_profile
  security_group_id = var.public_ec2_sg
  environment      = var.environment
  subnet_type      = "public"
  common_tags      = var.common_tags
}
module "private_ec2" {
  source           = "../../modules/ec2"
  ami_id           = data.aws_ami.amazon_linux_2.id
  instance_type    = "t3.small"
  subnet_ids       = var.private_subnet_ids
  fixed_ips        = [
    "10.0.32.101", "10.0.32.102", # Private Subnet 1
    "10.0.64.101", "10.0.64.102", # Private Subnet 2
    "10.0.96.101", "10.0.96.102"  # Private Subnet 3
  ]
  key_pair         = var.key_pair
  instance_profile = var.instance_profile
  security_group_id = var.private_ec2_sg
  environment      = var.environment
  subnet_type      = "private"
  common_tags      = var.common_tags
}