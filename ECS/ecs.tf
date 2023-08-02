resource "aws_ecs_cluster" "study_cluster" {
  name = "ecsstudy"

}

resource "aws_ecs_task_definition" "study_task" {
  family                   = "service-test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
        cpu       = 256
      memory    = 512
  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}


# resource "aws_ecs_service" "study_service" {
#   name            = "nginx"
#   cluster         = aws_ecs_cluster.study_cluster.id
#   task_definition = aws_ecs_task_definition.study_task.arn
#   desired_count   = 1

#   network_configuration {
#     security_groups  = [aws_security_group.ecs_sg.id]
#     subnets          = [aws_subnet.ecs_public_a.id,
#                         aws_subnet.ecs_public_c.id]
#  #   assign_public_ip =  true
#   }


#   load_balancer {
#     target_group_arn = aws_lb_target_group.ecs_lb_tg.arn
#     container_name   = "nginx"
#     container_port   = 80
#   }

# }


