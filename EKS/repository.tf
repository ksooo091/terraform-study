resource "aws_codecommit_repository" "frontend" {
  repository_name = "front"
  description     = "Demo Frontend"
}