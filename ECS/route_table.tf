

resource "aws_route_table" "eks_route_public_a" {
    vpc_id = aws_vpc.eks_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eks_igw.id
    }

    tags = {
        Name = "route_public_a"
    }
}

resource "aws_route_table_association" "route_a_public" {
    subnet_id = aws_subnet.ecs_public_a.id
    route_table_id = aws_route_table.ecs_route_public_a.id
}


resource "aws_route_table" "ecs_route_public_c" {
    vpc_id = aws_vpc.ecs_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ecs_igw.id
    }


    tags = {
        Name = "route_public_c"
    }
}

resource "aws_route_table_association" "route_c_public" {
    subnet_id = aws_subnet.ecs_public_c.id
    route_table_id = aws_route_table.ecs_route_public_c.id
}





# ##private_ecs1

# resource "aws_route_table" "ecs_private_a" {
#     vpc_id = aws_vpc.ecs_vpc.id


#     route {
#         cidr_block = "0.0.0.0/0"
#         nat_gateway_id = aws_nat_gateway.ecs_nat_a.id
#     }

#     tags = {
#         Name = "ecs_private_a"
#     }
# }

# resource "aws_route_table_association" "ecs_private_a" {
#     subnet_id = aws_subnet.ecs_private_a_1.id
#     route_table_id = aws_route_table.ecs_private_a.id
# }

# ##private_ecs2
# resource "aws_route_table" "ecs_private_c" {
#     vpc_id = aws_vpc.ecs_vpc.id

#     route {
#         cidr_block = "0.0.0.0/0"
#          nat_gateway_id = aws_nat_gateway.ecs_nat_c.id
#     }

#     tags = {
#         Name = "ecs_private_c"
#     }
# }

# resource "aws_route_table_association" "ecs_private_c" {
#     subnet_id = aws_subnet.ecs_private_c_1.id
#     route_table_id = aws_route_table.ecs_private_c.id
# }






