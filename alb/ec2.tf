resource "aws_security_group" "instance-sg" {
  name = "instance-sg"
  description = "Allow all HTTP an ssh"
  vpc_id = "${aws_vpc.alb_test_vpc.id}"
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
   ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "instance_a" {
    ami = "ami-00d253f3826c44195"
    availability_zone = "ap-northeast-2a"
    instance_type = "t2.micro"
    key_name = ""

    vpc_security_group_ids = [
        "${aws_security_group.instance-sg.id}",
    ]

    subnet_id = "${aws_subnet.alb_test_subnet_a.id}"
    associate_public_ip_address = true
}

resource "aws_instance" "instance_c" {
    ami = "ami-0557ee8955a41e419"
    availability_zone = "ap-northeast-2c"
    instance_type = "t4g.small"
    key_name = ""

    vpc_security_group_ids = [
        "${aws_security_group.instance-sg.id}",
    ]

    subnet_id = "${aws_subnet.alb_test_subnet_c.id}"
    associate_public_ip_address = true
}

