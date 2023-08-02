# Namespaces for Service Connect
resource "aws_service_discovery_http_namespace" "service_connect" {
  name        = "service_connect"
  description = "namespace for service connect"
}

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

  # Service Connect Configuration
  service_connect_configuration {
    enabled   = true
    namespace = aws_service_discovery_http_namespace.service_connect.name

    log_configuration {
      log_driver = "awslogs"
      options = {
        awslogs-group         = "/ecs/service-connect-web-dev"
        awslogs-region        = "ap-northeast-2"
        awslogs-stream-prefix = "ecs"
        awslogs-create-group  = "true"
      }
    }

    service {
      port_name             = "web"
      discovery_name        = "web"
      # ingress_port_override = 9901
      client_alias {
        # dns_name = "web"
        port     = 3000
      }
    }
  }

  task_definition = aws_ecs_task_definition.web.arn

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}
