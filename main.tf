# VPC for our Application and stuff

resource "aws_vpc" "my-vpc" {

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }

}

# Private subnet

resource "aws_subnet" "private-sub" {

  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private-sub"
  }

}

# Public subnet

resource "aws_subnet" "public-subnet" {

  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-subnet"
  }

}

# Internet Gateway

resource "aws_internet_gateway" "my-igw" {

  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-igw"
  }

}


# Route Table

resource "aws_route_table" "my-rt" {

  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "my-rt"
  }

}


# Associate public subnet with rt to give access to internet gateway

resource "aws_route_table_association" "public-sub" {

  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.my-rt.id

}