resource "aws_ecr_lifecycle_policy" "web" {
  policy = <<POLICY
{
  "rules": [
    {
      "action": {
        "type": "expire"
      },
      "description": "Untagged Images expire",
      "rulePriority": 1,
      "selection": {
        "countNumber": 1,
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "tagStatus": "untagged"
      }
    }
  ]
}
POLICY

  repository = aws_ecr_repository.web.id
}
