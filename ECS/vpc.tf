resource "aws_vpc" "ecs_vpc" {
    cidr_block = "172.16.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = "default"
    
    tags = {
        Name = "ecs_vpc"
    }
}



resource "aws_internet_gateway" "ecs_igw" {
    vpc_id = "${aws_vpc.ecs_vpc.id}"

    tags = {
        Name = "ECS-IGW"
    }
}



resource "aws_security_group" "ecs_sg" {
  name = "ecs-sg"
  description = "Allow all HTTP"
  vpc_id = aws_vpc.ecs_vpc.id
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
  }
}