provider "aws" {
  # Using a dedicated region us east 1
  region = "us-east-1"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key" 
}

# Creating a vpc, using a var vpc cidr
resource "aws_vpc" "main_vpc" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = "my-tf-vpc-network"
    # Enable following line after resource is created
    # Dept = "IT"
  }
}

# Creating a internet gateway and attach with a vpc
resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main IGW"
  }
}
# Public Subnet and attach with vpc
resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "Main Pubic"
  }
}
# Private subnet and attach with a vpc
resource "aws_subnet" "private" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  cidr_block = "10.10.2.0/24"

  tags = {
    Name = "Main Private"
  }
}
# Route Table , attach with IGW
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = "${aws_internet_gateway.main_gw.id}"
  }
}
# Attach route table with public subnet
resource "aws_route_table_association" "a" {
    subnet_id      = aws_subnet.public.id
    route_table_id = aws_route_table.public_rt.id
}

