# Codebuild role
resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-${var.env_name[terraform.workspace]}-service-role"

  assume_role_policy = data.aws_iam_policy_document.trust_codebuild.json
}

data "aws_iam_policy_document" "trust_codebuild" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "codebuild_policy" {
  name   = "CodeBuildBasePolicy-${var.env_name[terraform.workspace]}-${data.aws_region.current.name}"
  policy = file("./templates/codebuild-role-policy.json")
}

resource "aws_iam_role_policy_attachment" "codebuild-attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}