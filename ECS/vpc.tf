resource "aws_vpc" "ecs_vpc" {
    cidr_block = "172.20.0.0/16"
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