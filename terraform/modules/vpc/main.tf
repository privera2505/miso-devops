resource "aws_vpc" "basic_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "basic-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.basic_vpc.id

  tags = {
    Name = "basic-igw"
  }
}

# Subnets públicas (2 zonas de disponibilidad)
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.basic_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = { Name = "public-subnet-a" }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.basic_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = { Name = "public-subnet-b" }
}

# Tabla de rutas públicas
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.basic_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "public-rt" }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}
