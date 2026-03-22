output "ec2_id" {
    value = "${aws_instance.FrontEnd-Server.*.id}"
  
}
output "ec2_public_ip" {
    value = "${aws_instance.FrontEnd-Server[*].public_ip}"
  
}