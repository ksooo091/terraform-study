resource "aws_subnet" "ecs_public_a" {
    vpc_id  =  aws_vpc.ecs_vpc.id
    availability_zone   =   "ap-northeast-2a"
    cidr_block = "172.16.1.0/24"
    
    tags = {
        Name = "ecs public a"
    }
}



resource "aws_subnet" "ecs_public_c" {
    vpc_id  =  aws_vpc.ecs_vpc.id
    availability_zone   =   "ap-northeast-2c"
    cidr_block = "172.16.2.0/24"
    
    tags = {
        Name = "ecs public c"
    }
}





