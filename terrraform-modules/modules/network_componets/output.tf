output vpc_name {
  value       = var.vpc_name
}

output vpc_id {
  value       = aws_vpc.corp_vpc.id
}

output public_subnets_id {
  value       = "${aws_subnet.public_subnet.*.id}"
}

output private_subnets_id {
  value       = "${aws_subnet.private_subnet.*.id}"
}
