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
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "public_subnet-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_subnet" "web_subnet" {
  count                 = length(var.web_subnet)
  vpc_id                = aws_vpc.vpc.id
  cidr_block            = var.web_subnet[count.index]
  availability_zone     = var.availability_zones[count.index]

  tags = {
    Name = "web-subnet-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_subnet" "app_subnet" {
  count = length (var.app_subnet)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.app_subnet.cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "app_subnet-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_subnet" "db_subnet" {
  count = length (var.db_subnet)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.db_subnet.cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "db_subnet-${split("-", var.availability_zones[count.index])[2]}"
  }
}

## Internet Gateway for public
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-igw"
  }
}

## NAT-GATEWAY
resource "aws_eip" "ngw_ip" {
  count = length(var.availability_zones)
  domain   = "vpc"
}
resource "aws_nat_gateway" "nat_gateway" {
  count = length(var.availability_zones)
  allocation_id = aws_eip.ngw_ip.*.id[count.index]
  subnet_id     = aws_subnet.public_subnet.*.id[count.index]

  tags = {
    Name = "nat_gateway-${split("-", var.availability_zones[count.index])[2]}"
  }
}

## Route Table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

   tags = {
    Name = "public-rt-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_route_table" "web-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.*.id
  }

  tags = {
    Name = "web-rt-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_route_table" "app-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.*.id
  }

  tags = {
    Name = "app-rt-${split("-", var.availability_zones[count.index])[2]}"
  }
}

resource "aws_route_table" "db-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.*.id
  }

  tags = {
    Name = "db-rt-${split("-", var.availability_zones[count.index])[2]}"
  }
}

## Route Table Association
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet)
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public-rt.*.id[count.index]
}

resource "aws_route_table_association" "web" {
  count          = length(var.web_subnet)
  subnet_id      = aws_subnet.web_subnet.*.id[count.index]
  route_table_id = aws_route_table.web-rt.*.id[count.index]
}

resource "aws_route_table_association" "app" {
  count          = length(var.app_subnet)
  subnet_id      = aws_subnet.app_subnet.*.id[count.index]
  route_table_id = aws_route_table.app-rt.*.id[count.index]
}

resource "aws_route_table_association" "db" {
  count          = length(var.db_subnet)
  subnet_id      = aws_subnet.db_subnet.*.id[count.index]
  route_table_id = aws_route_table.db-rt.*.id[count.index]
}
