resource "aws_security_group" "albs-sg" {
  name = "albs-sg"
  description = "Allow all HTTP"
  vpc_id = "${aws_vpc.alb_test_vpc.id}"
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_lb_target_group" "elbstudy-tg" {
  name     = "elbstudy-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.alb_test_vpc.id
}

resource "aws_lb_target_group_attachment" "tg-c" {
  target_group_arn = aws_lb_target_group.elbstudy-tg.arn
  target_id        = aws_instance.instance_c.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg-a" {
  target_group_arn = aws_lb_target_group.elbstudy-tg.arn
  target_id        = aws_instance.instance_a.id
  port             = 80
}

resource "aws_lb" "elbstudy-alb" {
  name               = "elbstudy-alb"

  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.albs-sg.id}"]
  subnets            = ["${aws_subnet.alb_test_subnet_a.id}",
  "${aws_subnet.alb_test_subnet_c.id}"]

  enable_deletion_protection = true

 

}

resource "aws_lb_listener" "alb_listner" {
  load_balancer_arn = aws_lb.elbstudy-alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.elbstudy-tg.arn
  }
}