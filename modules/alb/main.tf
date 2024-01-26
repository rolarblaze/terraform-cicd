resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = var.subnets

  enable_deletion_protection = true
  drop_invalid_header_fields = true

  tags = {
    Environment = "production"
  }
}

#Listener
resource "aws_lb_listener" "lister" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

#Target Group
resource "aws_lb_target_group" "tg" {
  name     = "lbtg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
}

#Setting up target group attachment
resource "aws_lb_target_group_attachment" "tga" {
  count = length(var.instances)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instances[count.index]
  port             = 443
}
