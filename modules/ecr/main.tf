resource "aws_ecr_repository" "this" {
  name = var.name

  tags = {
    Name = var.name
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  policy = jsonencode(
    {
      "rules" : [
        {
          "rulePriority" : 1,
          "description" : "Hold only ${var.holding_count} images, expire all others",
          "selection" : {
            "tagStatus" : "any",
            "countType" : "imageCountMoreThan",
            "countNumber" : var.holding_count
          },
          "action" : {
            "type" : "expire"
          }
        }
      ]
    }
  )

  repository = aws_ecr_repository.this.name
}
