resource "aws_vpc" "alb_test_vpc" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "alb_test_subnet_a" {
  vpc_id     = aws_vpc.alb_test_vpc.id
  availability_zone = "ap-northeast-2a"
  cidr_block = "172.16.0.0/24"

}
resource "aws_subnet" "alb_test_subnet_c" {
  vpc_id     = aws_vpc.alb_test_vpc.id
  availability_zone = "ap-northeast-2c"
  cidr_block = "172.16.1.0/24"

}

resource "aws_internet_gateway" "alb_test_igw" {
  vpc_id     = aws_vpc.alb_test_vpc.id
}

resource "aws_route_table" "alb_test_route_table" {
   vpc_id     = aws_vpc.alb_test_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.alb_test_igw.id
    }
}

resource "aws_route_table_association" "alb_test_subnet_c_route" {
    subnet_id = aws_subnet.alb_test_subnet_c.id
    route_table_id = aws_route_table.alb_test_route_table.id
}

resource "aws_route_table_association" "alb_test_subnet_a_route" {
    subnet_id = aws_subnet.alb_test_subnet_a.id
    route_table_id = aws_route_table.alb_test_route_table.id
}