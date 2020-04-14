# Creating a vpc, using a var vpc cidr
resource "aws_vpc" "main_vpc2" {
  cidr_block       = var.vpc_cidr2

  tags = {
    Name = "my-tf-vpc2-network"
    # Enable following line after resource is created
    # Dept = "IT"
  }
}

# Creating a internet gateway and attach with a vpc
resource "aws_internet_gateway" "main_gw2" {
  vpc_id = "${aws_vpc.main_vpc2.id}"

  tags = {
    Name = "main IGW"
  }
}
# Public Subnet and attach with vpc
resource "aws_subnet" "public2" {
  vpc_id     = "${aws_vpc.main_vpc2.id}"
  cidr_block = "10.20.1.0/24"

  tags = {
    Name = "Main Pubic"
  }
}
# Private subnet and attach with a vpc
resource "aws_subnet" "private2" {
  vpc_id     = "${aws_vpc.main_vpc2.id}"
  cidr_block = "10.20.2.0/24"

  tags = {
    Name = "Main Private"
  }
}
# Route Table , attach with IGW
resource "aws_route_table" "public_rt2" {
  vpc_id = "${aws_vpc.main_vpc2.id}"

  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = "${aws_internet_gateway.main_gw2.id}"
  }
}
# Attach route table with public subnet
resource "aws_route_table_association" "a2" {
    subnet_id      = aws_subnet.public2.id
    route_table_id = aws_route_table.public_rt2.id
}