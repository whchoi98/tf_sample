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