resource "aws_vpc" "eks_vpc" {
    cidr_block = "172.20.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = "default"
    
    tags = {
        Name = "eks_vpc"
    }
}



resource "aws_internet_gateway" "eks_igw" {
    vpc_id = "${aws_vpc.eks_vpc.id}"

    tags = {
        Name = "EKS-IGW"
    }
}