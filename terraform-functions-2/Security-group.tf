resource "aws_security_group" "Terraform-vpc-sg" {
  name        = "${var.vpc_tag_name}-SG-allow_tls"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.Terraform-vpc.id

  dynamic "ingress" {
    for_each = var.ingress_value
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Allow traffic from any IP
    }
  }

  # Egress rule block
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow outbound traffic to any IP
  }

  # Tags block
  tags = {
    Name       = "${var.vpc_tag_name}-SG-allow_tls"
    Owner      = local.Owner
    costcenter = local.costcenter
    TeamTL     = local.TeamTL
  }
}
