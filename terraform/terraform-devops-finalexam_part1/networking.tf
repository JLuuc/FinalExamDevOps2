resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name    = "DevExam-VPC"
    Project = "DevOpsFinalExam"
  }
}

# Subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name    = "DevExam-PublicSubnet1"
    Project = "DevOpsFinalExam"
  }
}

# Subnet 2  ← we need both subnets in DIFFERENT AZs
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.2.0/24"          # ← make sure this does NOT overlap 10.0.1.0/24
  availability_zone       = "us-east-1b"          # ← pick a second AZ
  map_public_ip_on_launch = true
  tags = {
    Name    = "DevExam-PublicSubnet2"
    Project = "DevOpsFinalExam"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name    = "DevExam-IGW"
    Project = "DevOpsFinalExam"
  }
}

# Route Table for public subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = {
    Name    = "DevExam-PublicRouteTable"
    Project = "DevOpsFinalExam"
  }
}

# Associate subnets with that public route table
resource "aws_route_table_association" "public_rta1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_rta2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Security group allowing SSH + HTTP
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main_vpc.id
  description = "Allow SSH and HTTP inbound"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "DevExam-PublicSG"
    Project = "DevOpsFinalExam"
  }
}

