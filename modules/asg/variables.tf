variable "ami" {}
variable "instance_type" {}
variable "env" {}
variable "name" {}
variable "vpc_id" {}
variable "bastion_nodes" {}
variable "allow_port" {}
variable "allow_sg_cidr" {}
variable "subnet_ids" {}
variable "capacity" {
  default = {}
}
variable "asg" {}