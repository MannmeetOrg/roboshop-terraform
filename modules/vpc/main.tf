## VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr

  tags = {
    Name = "${var.env}-vpc"
  }
}

## SUBNETS
resource "aws_subnet" "public_subnet" {
  count = length (var.public_subnet)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet.cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "web_subnet" {
  count = length (var.web_subnet)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.web_subnet.cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "web_subnet"
  }
}

resource "aws_subnet" "app_subnet" {
  count = length (var.app_subnet)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.app_subnet.cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "app_subnet"
  }
}

resource "aws_subnet" "db_subnet" {
  count = length (var.db_subnet)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.db_subnet.cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "db_subnet"
  }
}

## Route Table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

   tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "web-rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "web-rt"
  }
}