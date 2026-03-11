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
    Name = "${var.vpc_tag_name}-Public-RT"
  }
}
resource "aws_route_table" "Terraform-vpc-PrivateRT" {
  vpc_id = aws_vpc.Terraform-vpc.id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.vpc_tag_name}-PrivateRT"
  }
}

resource "aws_route_table_association" "public-subnets" {
  count          = length(var.public_subnet_cidr_block)
  subnet_id      = element(aws_subnet.Terraform-vpc-public-sub.*.id, count.index)
  route_table_id = aws_route_table.Terraform-vpc-PublicRT.id
}
resource "aws_route_table_association" "private-subnets" {
  count          = length(var.private_subnet_cidr_block)
  subnet_id      = element(aws_subnet.Terraform-vpc-private-sub.*.id, count.index)
  route_table_id = aws_route_table.Terraform-vpc-PrivateRT.id
}

# resource "aws_instance" "web-1" {
#   ami                         = var.ami_ID
#   availability_zone           = var.Az_Subnet1
#   instance_type               = var.Ec2_InstacneType
#   key_name                    = var.Ec2_Key
#   subnet_id                   = aws_subnet.Terraform-vpc-public-sub1.id
#   vpc_security_group_ids      = [aws_security_group.Terraform-vpc-sg.id]
#   associate_public_ip_address = true
#   tags = {
#     Name = "web-1"
#   }
# }

resource "aws_s3_bucket" "ankiterra12342222" {
  bucket = "ankiterra123422222"

  tags = {
    Name = "ankiterra12342222"
  }

  depends_on = [aws_route_table.Terraform-vpc-PublicRT]
}

resource "aws_s3_bucket" "AnkitTerra567" {
  bucket = "ankiterra567"

  tags = {
    Name = "ankiterra567"
  }
  depends_on = [aws_s3_bucket.ankiterra12342222]
}


