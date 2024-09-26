env                   = "dev"


vpc = {
  cidr                = "10.0.0.0/16"
  public_subnets      = ["10.10.0.0/24", "10.10.1.0/24" ]
  web_subnets         = ["10.10.2.0/24", "10.10.3.0/24" ]
  app_subnets         = ["10.10.4.0/24", "10.10.5.0/24" ]
  db_subnets          = ["10.10.6.0/24", "10.10.7.0/24" ]
  availability_zones  = ["us-east-1a", "us-east-1b"]
  default_vpc_id      = "vpc-027bb446dd3568149"
  default_vpc_rt      = "rtb-00238bf7822dd79e2"
  default_vpc_cidr    = "172.31.0.0/16"

}

# ec2 = {
#   ami           = "ami-066784287e358dad1"
#   instance_type = "t2.micro"
# }