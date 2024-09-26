
module "vpc" {
  source = "./modules/vpc"

  cidr                = var.vpc["cidr"]
  env                 = var.env
  public_subnet       = var.vpc["public_subnet"]
  web_subnet          = var.vpc["web_subnet"]
  app_subnet          = var.vpc["app_subnet"]
  db_subnet           = var.vpc["db_subnet"]
  availability_zones  = var.vpc["availability_zones"]
  default_vpc_id      = var.vpc["default_vpc_id"]
  default_vpc_rt      = var.vpc["default_vpc_rt"]
  default_vpc_cidr    = var.vpc["default_vpc_cidr"]
}

# module "ec2" {
#   source = "./modules/ec2"
#   ami                  = var.ami
#   instance_type        = var.instance_type
#   env                  = var.env
# }