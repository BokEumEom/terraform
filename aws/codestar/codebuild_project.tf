# ---------------------------------------------------------------------------------------------------------------------
# Code Build
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_codebuild_project" "codebuild" {
  for_each = local.web_service

  artifacts {
    encryption_disabled    = "false"
    name                   = each.value.ServiceName
    override_artifact_name = "false"
    packaging              = "NONE"
    type                   = "CODEPIPELINE"
  }

  badge_enabled = "false"
  build_timeout = "60"

  cache {
    type = "NO_CACHE"
  }

  # concurrent_build_limit = "0"
  encryption_key = "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:alias/aws/s3"

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = "false"
    type                        = "LINUX_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }

    s3_logs {
      encryption_disabled = "false"
      status              = "DISABLED"
    }
  }

  name           = "${each.value.ServiceName}-${var.env_name[terraform.workspace]}"
  queued_timeout = "480"
  service_role   = aws_iam_role.codebuild_role.arn

  source {
    buildspec           = "version: 0.2\n\n#env:\n  #variables:\n     # key: \"value\"\n     # key: \"value\"\n  #parameter-store:\n     # key: \"value\"\n     # key: \"value\"\n  #secrets-manager:\n     # key: secret-id:json-key:version-stage:version-id\n     # key: secret-id:json-key:version-stage:version-id\n  #exported-variables:\n     # - variable\n     # - variable\n  #git-credential-helper: yes\n#batch:\n  #fast-fail: true\n  #build-list:\n  #build-matrix:\n  #build-graph:\nphases:\n  #install:\n    #If you use the Ubuntu standard image 2.0 or later, you must specify runtime-versions.\n    #If you specify runtime-versions and use an image other than Ubuntu standard image 2.0, the build fails.\n    #runtime-versions:\n      # name: version\n      # name: version\n    #commands:\n      # - command\n      # - command\n  #pre_build:\n    #commands:\n      # - command\n      # - command\n  build:\n    commands:\n      # - command\n      # - command\n  post_build:\n    commands:\n       - printf '[{\"name\":\"${each.value.ServiceName}\",\"imageUri\":\"%s\"}]' ${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${each.value.ServiceName}:${var.image_tag[terraform.workspace]} > imagedefinitions.json\n      # - command\n#reports:\n  #report-name-or-arn:\n    #files:\n      # - location\n      # - location\n    #base-directory: location\n    #discard-paths: yes\n    #file-format: JunitXml | CucumberJson\nartifacts:\n  files: imagedefinitions.json\n    # - location\n    # - location\n  #name: $(date +%Y-%m-%d)\n  #discard-paths: yes\n  #base-directory: location\n#cache:\n  #paths:\n    # - paths"
    git_clone_depth     = "0"
    insecure_ssl        = "false"
    report_build_status = "false"
    type                = "CODEPIPELINE"
  }

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}