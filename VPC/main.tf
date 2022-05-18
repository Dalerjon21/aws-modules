
# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.21.0.0/16"
  tags = {
    Name = "default-VPC"
  }
}


# Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.21.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public-Subnet"
  }
}


# Create Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.21.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Private-Subnet"
  }
}


# Creating Public Route Table
resource "aws_route_table" "Public_RT" {
vpc_id = aws_vpc.main.id
tags = {
"Name" = "Public Route Table"
}
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_nat_gateway.NAT_gateway.id
}
}


# Creating Private Route Table
resource "aws_route_table" "Private_RT" {
vpc_id = aws_vpc.main.id
tags = {
"Name" = "Private Route Table"
}
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_nat_gateway.NAT_gateway.id
}
}


# Creating NAT Gateway
resource "aws_nat_gateway" "NAT_gateway" {
  allocation_id = aws_eip.Elastic_IP.id
  subnet_id     = aws_subnet.private_subnet.id

  tags = {
    Name = "NAT Gateway"
  }
}

# Creating EIP 
resource "aws_eip" "Elastic_IP" {
  vpc      = true
}

