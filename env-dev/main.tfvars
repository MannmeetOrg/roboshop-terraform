env = "dev"


vpc = {
  cidr               = 10.0.0.0/16
  default_vpc_id     = "vpc-0928c2748fecca727"
#   default_vpc_rt     = "rtb-085f965c93773f7e5"
#   default_vpc_cidr   = "172.31.0.0/16"

}

ec2 = {
  ami           = "ami-066784287e358dad1"
  instance_type = "t2.micro"
}