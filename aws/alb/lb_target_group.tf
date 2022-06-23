resource "aws_lb_target_group" "ecs_fargate_api_gateway" {
  deregistration_delay = "30"

  health_check {
    enabled             = "true"
    healthy_threshold   = "3"
    interval            = "30"
    matcher             = "200"
    path                = "/system/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
    unhealthy_threshold = "2"
  }

  load_balancing_algorithm_type = "round_robin"
  name                          = "ecs-fg-${var.app_prefix}-api-gw-tg"
  port                          = "80"
  protocol                      = "HTTP"
  protocol_version              = "HTTP1"
  slow_start                    = "0"

  stickiness {
    cookie_duration = "86400"
    enabled         = "false"
    type            = "lb_cookie"
  }

  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}