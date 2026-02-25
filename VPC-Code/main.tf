provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "Terraform-vpc" {
  cidr_block = "172.16.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "Terraform-vpc"
  }
}

resource "aws_internet_gateway" "Terraform-vpc-igw" {
  vpc_id = aws_vpc.Terraform-vpc.id

  tags = {
    Name = "Terraform-vpc-igw"
  }
}

resource "aws_security_group" "Terraform-vpc-sg" {
  name        = "allow_tls"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.Terraform-vpc.id

  tags = {
    Name = "Terraform-vpc-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Terraform-vpc-sg" {
  security_group_id = aws_security_group.Terraform-vpc-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "Terraform-vpc-sg" {
  security_group_id = aws_security_group.Terraform-vpc-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_subnet" "Terraform-vpc-public-sub1" {
  vpc_id     = aws_vpc.Terraform-vpc.id
  cidr_block = "172.16.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Terraform-vpc-public-sub1"
  }
}

resource "aws_subnet" "Terraform-vpc-public-sub2" {
  vpc_id     = aws_vpc.Terraform-vpc.id
  cidr_block = "172.16.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Terraform-vpc-public-sub2"
  }
}

resource "aws_route_table" "Terraform-vpc-PublicRT" {
  vpc_id = aws_vpc.Terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Terraform-vpc-igw.id
  }
  
  route {
    cidr_block = "172.16.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "Terraform-vpc-PublicRT"
  }
}

resource "aws_route_table_association" "Terraform-vpc-PublicRT-1" {
  subnet_id      = aws_subnet.Terraform-vpc-public-sub1.id
  route_table_id = aws_route_table.Terraform-vpc-PublicRT.id
}
resource "aws_route_table_association" "Terraform-vpc-PublicR-b" {
  subnet_id      = aws_subnet.Terraform-vpc-public-sub2.id
  route_table_id = aws_route_table.Terraform-vpc-PublicRT.id
}




