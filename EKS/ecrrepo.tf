resource "aws_ecr_repository" "backend_ecr_repo" {
  name = "Back ECR Repo"
}

resource "aws_ecr_repository" "frontend_ecr_repo" {
  name = "Front ECR Repo"
}


