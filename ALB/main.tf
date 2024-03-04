resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id


 tags = {
    Name = "app-tg-devops"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = var.project-asg
  lb_target_group_arn   = aws_lb_target_group.app_tg.arn
}
resource "aws_lb" "app_alb" {
  name               = "app-alb"

  load_balancer_type = "application"
  security_groups    = [var.security_groups]
  subnets            = [var.public_subnet1,var.public_subnet2]

  # lifecycle {
  #   create_before_destroy = true
  # }

  tags = {
    Name = "app-alb-devops"
  }
}


resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.app_tg.arn
    type             = "forward"
  
  }
}