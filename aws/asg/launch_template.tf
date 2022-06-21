resource "aws_launch_template" "ecs_launch_template" {
  default_version         = "1"
  disable_api_termination = "false"

  iam_instance_profile {
    arn = "arn:aws:iam::account:instance-profile/ecsInstanceRole"
  }

  image_id      = "ami-04d6accb291941993"
  instance_type = "g4dn.xlarge"
  key_name      = "key"
  name          = "ECSLaunchTemplate-${var.env_name[terraform.workspace]}"
  user_data = (base64encode(<<EOF
  #!/bin/bash
  echo ECS_CLUSTER=ecs-dev-cluster >> /etc/ecs/ecs.config;
  EOF
  ))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ecs_cluster_gpu_instance"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}