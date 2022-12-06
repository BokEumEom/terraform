# ECS Task Definition
resource "aws_ecs_task_definition" "jaeger" {
  family                   = "${var.app_prefix}-dev-jaeger"
  task_role_arn            = aws_iam_role.ecs_task.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = var.app_cpu
  memory                   = "2048"
  requires_compatibilities = ["FARGATE"]

  container_definitions = templatefile("./templates/task_container_definations_jaeger.json", {
    app_cpu        = var.app_cpu
    app_memory     = "2048"
    awslogs-region = "${data.aws_region.current.name}"
  })

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }

  tags = local.common_tags
}

# ECS Service
resource "aws_ecs_service" "jaeger" {
  cluster = aws_ecs_cluster.cluster.id

  deployment_circuit_breaker {
    enable   = "true"
    rollback = "true"
  }

  deployment_controller {
    type = "ECS"
  }

  force_new_deployment               = "true"
  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "100"
  desired_count                      = "1"
  enable_ecs_managed_tags            = "true"
  enable_execute_command             = "false"
  health_check_grace_period_seconds  = "0"
  launch_type                        = "FARGATE"
  name                               = "jaeger"

  load_balancer {
    container_name   = "jaeger"
    container_port   = "16686"
    target_group_arn = aws_lb_target_group.ecs-fargate-jaeger.arn
  }

  network_configuration {
    assign_public_ip = "false"
    security_groups  = [aws_security_group.coinness_dev_ecs_sg.id]
    # subnets          = data.aws_subnet_ids.dev_private.ids
    subnets = data.aws_subnets.private.ids
  }

  service_registries {
    container_port = "0"
    port           = "0"
    registry_arn   = aws_service_discovery_service.jaeger.arn
  }

  platform_version    = "LATEST"
  scheduling_strategy = "REPLICA"

  task_definition = aws_ecs_task_definition.jaeger.arn

  tags = local.common_tags
}

# Autoscaling
# module "jaeger_autoscaling" {
#   source = "../modules/ecs_appautoscaling"

#   cluster_name     = aws_ecs_cluster.cluster.name
#   service_name     = aws_ecs_service.jaeger.name
#   min_capacity     = 1
#   max_capacity     = 4
#   cpu_target_value = 60
#   mem_target_value = 75
#   role_arn         = data.aws_iam_role.AutoScaling_ECSService.arn
# }