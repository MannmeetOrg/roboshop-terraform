env = "dev"


vpc = {
  cidr               = 10.0.0.0/16
  public_subnet      = ["10.10.0.0", "10.10.1.0" ]
  web_subnet         = ["10.10.2.0", "10.10.3.0" ]
  app_subnet         = ["10.10.4.0", "10.10.5.0" ]
  db_subnet          = ["10.10.6.0", "10.10.7.0" ]
  availability_zone  = ["us-east-1", "us-west-1"]
  default_vpc_id     = "vpc-0928c2748fecca727"
#   default_vpc_rt     = "rtb-085f965c93773f7e5"
#   default_vpc_cidr   = "172.31.0.0/16"

}

ec2 = {
  ami           = "ami-066784287e358dad1"
  instance_type = "t2.micro"
}