resource "aws_lb_target_group" "my_tg" {
  name     = "my-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

resource "aws_lb" "web_elb" {
  name               = "${terraform.workspace}-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.asg_sg.id]
  subnets            = local.pub_sub_ids

  enable_deletion_protection = false
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.web_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}
