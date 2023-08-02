resource "aws_lb_target_group" "ecs_lb_tg" {
  name     = "ecs-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ecs_vpc.id
    target_type = "ip"
  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

}


resource "aws_lb" "ecs_alb" {
  name               = "ecs-alb"

  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_sg.id]
    subnets          = [
                        aws_subnet.ecs_public_a.id,
                        aws_subnet.ecs_public_c.id
                       ]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "alb_listner" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_lb_tg.arn
  }
}