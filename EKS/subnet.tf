resource "aws_subnet" "eks_public_a" {
    vpc_id  =  aws_vpc.eks_vpc.id
    availability_zone   =   "ap-northeast-1a"
    cidr_block = "172.20.1.0/24"
    
    tags = {
        Name = "EKS public a"
    }
}



resource "aws_subnet" "eks_public_c" {
    vpc_id  =  aws_vpc.eks_vpc.id
    availability_zone   =   "ap-northeast-1c"
    cidr_block = "172.20.2.0/24"
    
    tags = {
        Name = "EKS public c"
    }
}








resource "aws_subnet" "eks_private_a_1" {
    vpc_id = aws_vpc.eks_vpc.id
    availability_zone = "ap-northeast-1a"
    cidr_block = "172.20.10.0/24"

    tags = {
        Name = "EKS private a"
    }
}

resource "aws_subnet" "eks_private_c_1" {
    vpc_id = aws_vpc.eks_vpc.id
    availability_zone = "ap-northeast-1c"
    cidr_block = "172.20.11.0/24"

    tags = {
        Name = "EKS private c"
    }
}



resource "aws_subnet" "eks_private_a_2" {
    vpc_id = aws_vpc.eks_vpc.id
    availability_zone = "ap-northeast-1a"
    cidr_block = "172.20.20.0/24"

    tags = {
        Name = "For Aurora"
    }
}


resource "aws_subnet" "eks_private_c_2" {
    vpc_id = aws_vpc.eks_vpc.id
    availability_zone = "ap-northeast-1c"
    cidr_block = "172.20.21.0/24"

    tags = {
        Name = "For Aurora"
    }
}