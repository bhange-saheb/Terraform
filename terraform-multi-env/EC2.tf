resource "aws_instance" "web-1" {
  ami                         = var.ami_ID
  availability_zone           = var.Az_Subnet1
  instance_type               = var.Ec2_InstacneType
  key_name                    = var.Ec2_Key
  subnet_id                   = aws_subnet.Terraform-vpc-public-sub1.id
  vpc_security_group_ids      = [aws_security_group.Terraform-vpc-sg.id]
  associate_public_ip_address = true
  tags = {
    Name        = "${var.env}-Server"
    Environment = "${var.env}"
  }
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl start nginx
              systemctl enable nginx

              cat <<HTML > /var/www/html/index.html
              <html>
              <h1>Hello Cloud Gurus 🚀</h1>
              <h2>Region: ${var.Az_Subnet1}</h2>
              <h2>Environment: ${var.env}</h2>
              </html>
              HTML

              systemctl restart nginx
            EOF
}