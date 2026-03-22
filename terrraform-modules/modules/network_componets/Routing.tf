resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.corp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.corp_vpc_igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-RT"
  }

}

resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.corp_vpc.id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }
  tags = {
    Name = "${var.vpc_name}-public-RT"
  }
}

resource "aws_route_table_association" "publicRT-association" {
    route_table_id = aws_route_table.public_RT.id
    count          = length(var.public_subnets_cidr)
    subnet_id = element(aws_subnet.public_subnet.*.id,count.index)
  
}

resource "aws_route_table_association" "privateRT-association" {
    route_table_id = aws_route_table.private_RT.id
    count          = length(var.private_subnets_cidr)
    subnet_id = element(aws_subnet.private_subnet.*.id,count.index)
  
}
