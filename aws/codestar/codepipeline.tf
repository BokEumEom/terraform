# ---------------------------------------------------------------------------------------------------------------------
# Code Pipeline
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_codepipeline" "pipeline" {
  for_each = local.web_service

  artifact_store {
    location = "codepipeline-ap-northeast-2-xxxxxxxxxxxx"
    type     = "S3"
  }

  name     = "${each.value.ServiceName}-${var.env_name[terraform.workspace]}"
  role_arn = aws_iam_role.codepipeline_role.arn

  stage {
    action {
      category = "Source"

      configuration = {
        ImageTag       = var.image_tag[terraform.workspace]
        RepositoryName = each.value.ServiceName
      }

      name             = "Source"
      namespace        = "SourceVariables"
      output_artifacts = ["SourceArtifact"]
      owner            = "AWS"
      provider         = "ECR"
      region           = data.aws_region.current.name
      run_order        = "1"
      version          = "1"
    }

    name = "Source"
  }

  stage {
    action {
      category = "Build"

      configuration = {
        ProjectName = "${each.value.ServiceName}-${var.env_name[terraform.workspace]}"
      }

      input_artifacts  = ["SourceArtifact"]
      name             = "Build"
      namespace        = "BuildVariables"
      output_artifacts = ["BuildArtifact"]
      owner            = "AWS"
      provider         = "CodeBuild"
      region           = data.aws_region.current.name
      run_order        = "1"
      version          = "1"
    }

    name = "Build"
  }

  stage {
    action {
      category = "Deploy"

      configuration = {
        ClusterName       = "${aws_ecs_cluster.cluster.name}"
        DeploymentTimeout = "10"
        ServiceName       = each.value.ServiceName
      }

      input_artifacts = ["BuildArtifact"]
      name            = "Deploy"
      namespace       = "DeployVariables"
      owner           = "AWS"
      provider        = "ECS"
      region          = data.aws_region.current.name
      run_order       = "1"
      version         = "1"
    }

    name = "Deploy"
  }

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}