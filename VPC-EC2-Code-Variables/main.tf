provider "aws" {
  region = var.region_name
}

resource "aws_vpc" "Terraform-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = "true"

  tags = {
    Name = var.vpc_tag_name
  }
}

resource "aws_internet_gateway" "Terraform-vpc-igw" {
  vpc_id = aws_vpc.Terraform-vpc.id

  tags = {
    Name = var.igw_tag_name
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
  vpc_id            = aws_vpc.Terraform-vpc.id
  cidr_block        = var.subnet1_cidr_block
  availability_zone = var.Az_Subnet1

  tags = {
    Name = "Terraform-vpc-public-sub1"
  }
}

resource "aws_subnet" "Terraform-vpc-public-sub2" {
  vpc_id            = aws_vpc.Terraform-vpc.id
  cidr_block        = var.subnet2_cidr_block
  availability_zone = var.Az_Subnet2

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
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "Terraform-vpc-PublicRT"
  }
}

resource "aws_route_table_association" "Terraform_vpc_PublicRT_1" {
  subnet_id      = aws_subnet.Terraform-vpc-public-sub1.id
  route_table_id = aws_route_table.Terraform-vpc-PublicRT.id
}
resource "aws_route_table_association" "Terraform-vpc-PublicR-b" {
  subnet_id      = aws_subnet.Terraform-vpc-public-sub2.id
  route_table_id = aws_route_table.Terraform-vpc-PublicRT.id
}

resource "aws_instance" "web-1" {
  ami                         = var.ami_ID
  availability_zone           = var.Az_Subnet1
  instance_type               = var.Ec2_InstacneType
  key_name                    = var.Ec2_Key
  subnet_id                   = aws_subnet.Terraform-vpc-public-sub1.id
  vpc_security_group_ids      = [aws_security_group.Terraform-vpc-sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "web-1"
  }
}

resource "aws_s3_bucket" "ankitTerra1234" {
  bucket = "ankitTerra1234"

  tags = {
    Name = "ankitTerra1234"
  }

  depends_on = [aws_route_table_association.Terraform_vpc_PublicRT_1]
}

resource "aws_s3_bucket" "AnkitTerra567" {
  bucket = "AnkitTerra567"

  tags = {
    Name = "AnkitTerra567"
  }
  depends_on = [aws_s3_bucket.ankitTerra1234]
}


