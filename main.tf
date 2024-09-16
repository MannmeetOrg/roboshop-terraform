
module "vpc" {
  source = "./modules/vpc"

  cidr = var.vpc["cidr"]
  env  = var.env
  vpc  = var.vpc.default_vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  ami                  = var.ami
  instance_type        = var.instance_type
  env                  = var.env
}