resource "aws_cloudwatch_metric_alarm" "ecs_cpu_utilization_too_high" {
  for_each                  = local.all_ecs
  alarm_description         = "Average EC2 CPU utilization over last 5 minutes too high"
  alarm_name                = "${each.key} ECS HighCPUUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  datapoints_to_alarm       = "3"
  period                    = "60"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  ok_actions                = [var.aws_sns_topic_arn]
  alarm_actions             = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  statistic                 = "Average"
  threshold                 = "80"
  treat_missing_data        = "missing"

  dimensions = {
    ServiceName = each.value.ServiceName
    ClusterName = "cluster"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_mem_utilization_too_high" {
  for_each                  = local.all_ecs
  alarm_description         = "Average ECS Memory utilization over last 1 minutes too high"
  alarm_name                = "${each.key} ECS HighMEMUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  datapoints_to_alarm       = "3"
  period                    = "60"
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  ok_actions                = [var.aws_sns_topic_arn]
  alarm_actions             = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  statistic                 = "Average"
  threshold                 = "80"
  treat_missing_data        = "missing"

  dimensions = {
    ServiceName = each.value.ServiceName
    ClusterName = "cluster"
  }
}
