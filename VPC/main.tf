resource "aws_vpc" "star_vpc" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "star_vpc"
  }
}
# Create Public Subnet
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.star_vpc.id
  cidr_block              = "10.0.1.0/24"
    availability_zone = "us-east-2a"

  tags = {
    Name = "public_subnet1"
  }
}

# Create Public Subnet
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.star_vpc.id
  cidr_block              = "10.0.3.0/24"
    availability_zone = "us-east-2b"

  tags = {
    Name = "public_subnet1"
  }
}


# Create Private Subnet
resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.star_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "private_subnet2"
  }
}


# Create Private Subnet
resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.star_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "private_subnet2"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "star_ig" {
  vpc_id = aws_vpc.star_vpc.id
  tags = {
    Name = "star_ig"
  }
}

# Create Route Table
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.star_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.star_ig.id
  }

  tags = {
    Name = "my_rt"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "star_nat" {
  allocation_id = aws_eip.star_eip.id
  subnet_id     = aws_subnet.private_subnet2.id
  tags = {
    Name = "star_nat"
  }
}
# Associate Subnet with Route Table
resource "aws_route_table_association" "star_rta" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.my_rt.id
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "star_eip" {
  tags = {
    Name = "star_eip"
  }
}


# Create Network ACL
resource "aws_network_acl" "star_nacl" {
  vpc_id = aws_vpc.star_vpc.id

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "star_nacl"
  }
}

