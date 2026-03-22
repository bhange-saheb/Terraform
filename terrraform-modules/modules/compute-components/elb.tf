resource "aws_lb" "network_lb" {
  name               = "${var.environment}-network-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnets_id
  enable_deletion_protection = false
  tags = {
    Environment = var.environment
    Name = "${var.vpc_name}-network-lb"
  }
}

resource "aws_lb_target_group" "network_lb_tg" {
  name     = "network-lb-tetg"
  port     = 80
  protocol = "TCP"
  vpc_id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "attach_tg" {
  count = "${var.environment == "Prod" ? 3 : 1}"
  target_group_arn = aws_lb_target_group.network_lb_tg.arn
  target_id        = "${element(var.ec2_id, count.index)}"
  port             = 80
  
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.network_lb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.network_lb_tg.arn
  }
}