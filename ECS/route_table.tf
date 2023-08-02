

resource "aws_route_table" "ecs_route_public_a" {
    vpc_id = aws_vpc.ecs_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ecs_igw.id
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



