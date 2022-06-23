resource "aws_iam_role" "codepipeline_role" {
  name = "AWSCodePipelineServiceRole-${data.aws_region.current.name}-${var.env_name[terraform.workspace]}"

  assume_role_policy = data.aws_iam_policy_document.trust_codepipeline.json
}

data "aws_iam_policy_document" "trust_codepipeline" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}
resource "aws_iam_policy" "codepipeline_policy" {
  name   = "AWSCodePipelineServicePolicy-${var.env_name[terraform.workspace]}"
  policy = file("./templates/codepipeline-role-policy.json")
}

resource "aws_iam_role_policy_attachment" "role" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}