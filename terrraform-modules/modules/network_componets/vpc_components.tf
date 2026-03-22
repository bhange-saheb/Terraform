resource "aws_vpc" "corp_vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    tags = {
      Name = var.vpc_name
    }
    
}

resource "aws_internet_gateway" "corp_vpc_igw" {
    vpc_id = aws_vpc.corp_vpc.id
    tags = {
      Name = "${var.vpc_name}-IGW"
    }
  
}