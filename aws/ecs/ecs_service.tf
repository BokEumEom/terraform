# ECS Service
resource "aws_ecs_service" "web" {
  cluster = aws_ecs_cluster.cluster.id

  deployment_circuit_breaker {
    enable   = "true"
    rollback = "true"
  }

  deployment_controller {
    type = "ECS"
  }

  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "100"
  desired_count                      = "1"
  enable_ecs_managed_tags            = "true"
  enable_execute_command             = "false"
  health_check_grace_period_seconds  = "0"
  launch_type                        = "FARGATE"
  name                               = "web"
  force_new_deployment               = "true"

  network_configuration {
    assign_public_ip = "false"
    security_groups  = aws_security_group.web_sg.id
    subnets          = data.aws_subnets.private.ids
  }

  platform_version    = "LATEST"
  scheduling_strategy = "REPLICA"

  service_registries {
    container_port = "0"
    port           = "0"
    registry_arn   = aws_service_discovery_service.web.arn
  }

  task_definition = aws_ecs_task_definition.web.arn

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}