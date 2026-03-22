resource "aws_subnet" "Terraform-vpc-public-sub" {
  count             = length(var.public_subnet_cidr_block)
  vpc_id            = aws_vpc.Terraform-vpc.id
  cidr_block        = element(var.public_subnet_cidr_block, count.index)
  availability_zone = element(var.Az_Subnet, count.index)

  tags = {
    Name       = "${var.vpc_tag_name}-public-Subnet-${count.index + 1}"
    Owner      = local.Owner
    costcenter = local.costcenter
    TeamDL     = local.TeamTL
  }
}

resource "aws_subnet" "Terraform-vpc-private-sub" {
  count             = length(var.private_subnet_cidr_block)
  vpc_id            = aws_vpc.Terraform-vpc.id
  cidr_block        = element(var.private_subnet_cidr_block, count.index)
  availability_zone = element(var.Az_Subnet, count.index)

  tags = {
    Name       = "${var.vpc_tag_name}-private-Subnet-${count.index + 1}"
    Owner      = local.Owner
    costcenter = local.costcenter
    TeamDL     = local.TeamTL
  }
}
