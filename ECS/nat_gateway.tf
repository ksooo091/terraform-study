# resource "aws_nat_gateway" "ecs_nat_a" {
#     allocation_id = aws_eipnat_gy_eip_a.id
#     subnet_id = aws_subnet.ecs_public_id

#     tags = {
#         Name = "nat_a"
#     }
# }

# resource "aws_nat_gateway" "ecs_nat_c" {
#     # allocation_id = aws_eip.nat_gy_eip_c.id
#     subnet_id = aws_subnet.ecs_public_c.id

#         tags = {
#         Name = "nat_c"
#     }
# }