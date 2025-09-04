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

  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

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


######################################################################
#################### EC2 Instance ####################################
######################################################################

resource "aws_instance" "webserver" {

  instance_type               = "t2.micro"
  ami                         = "ami-0861f4e788f5069dd"
  subnet_id                   = aws_subnet.public-subnet.id
  associate_public_ip_address = true
  availability_zone           = "ap-south-1a"


  vpc_security_group_ids = [aws_security_group.ec2-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable php7.4
              yum install -y httpd php php-mysqlnd wget unzip
              
              cd /var/www/html
              wget https://wordpress.org/latest.tar.gz
              tar -xzf latest.tar.gz
              cp -r wordpress/* .
              rm -rf wordpress latest.tar.gz
              
              chown -R apache:apache /var/www/html
              chmod -R 755 /var/www/html
              
              systemctl enable httpd
              systemctl start httpd
              EOF

  tags = {
    Name = "wordpress-ec2"
  }

}