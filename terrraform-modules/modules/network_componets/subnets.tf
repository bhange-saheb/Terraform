resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnets_cidr)
  vpc_id            = aws_vpc.corp_vpc.id
  cidr_block        = element(var.public_subnets_cidr, count.index)
  availability_zone = element(var.Azs, count.index)

  tags = {
    Name = "${var.vpc_name}-public_subnets-${count.index +1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.corp_vpc.id
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.Azs, count.index)

  tags = {
    Name = "${var.vpc_name}-private_subnets-${count.index +1}"
  }
}