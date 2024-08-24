resource "aws_instance" "ec2-instance" {
  ami                  = var.ami
  instance_type        = var.instance_type

}