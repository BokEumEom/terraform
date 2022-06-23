resource "aws_lb_listener_rule" "listener_rule_ecs_service" {
  /* action {
    type = "forward"
    forward {
      stickiness {
        duration = 86400
        enabled  = false
      }
      target_group {
        arn    = aws_lb_target_group.ecs-fargate-tg.arn
        weight = 0
      }
      target_group {
        arn    = aws_lb_target_group.ecs-fargate-tg-new.arn
        weight = 100
      }
    }
  } */

  action {
    order            = "1"
    target_group_arn = aws_lb_target_group.ecs_fargate_api_gateway.arn
    type             = "forward"
  }

  # condition {
  #   path_pattern {
  #     values = ["/*"]
  #   }
  # }

  condition {
    host_header {
      values = ["api.example.com"]
    }
  }

  listener_arn = aws_lb_listener.https.arn
  priority     = "101"
}
