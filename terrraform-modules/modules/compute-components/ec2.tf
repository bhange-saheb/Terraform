resource "aws_instance" "FrontEnd-Server" {
  count                       = var.environment == "Prod" ? 3 : 1
  ami                         = lookup(var.ami_IDs, var.region_name)
  instance_type               = var.Ec2_InstacneType
  key_name                    = var.Ec2_Key
  subnet_id                   = element(var.public_subnets_id, count.index)
  vpc_security_group_ids      = ["${var.sg_id}"]
  associate_public_ip_address = true
  tags = {
    Name = "${var.vpc_name}-Server -${count.index + 1}"
  }
}
