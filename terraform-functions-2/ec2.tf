resource "aws_instance" "FrontEnd-Server" {
  count                       = lookup(var.environment, var.region_name) == "Prod" ? 3 : 1
  ami                         = lookup(var.ami_IDs, var.region_name)
  instance_type               = var.Ec2_InstacneType
  key_name                    = var.Ec2_Key
  subnet_id                   = element(aws_subnet.Terraform-vpc-public-sub.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.Terraform-vpc-sg.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "FrontEnd-server -${count.index + 1}"
  }
}
