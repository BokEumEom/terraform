resource "aws_cloudwatch_metric_alarm" "target_group_healthy" {
  # for_each                  = toset(data.aws_instances.all_ec2.ids)
  alarm_description         = "This metric monitors ec2 status check."
  alarm_name                = "water-prod-app-tg Target Group HealthyHostCount"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "1"
  datapoints_to_alarm       = "1"
  period                    = "60"
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  ok_actions                = [var.aws_sns_topic_arn]
  alarm_actions             = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  statistic                 = "Maximum"
  threshold                 = "1"
  treat_missing_data        = "missing"

  dimensions = {
    TargetGroup  = var.target_group
    LoadBalancer = var.load_balancer
  }
}

resource "aws_cloudwatch_metric_alarm" "target_group_unhealthy" {
  # for_each                  = toset(data.aws_instances.all_ec2.ids)
  alarm_description         = "This metric monitors ec2 status check."
  alarm_name                = "water-prod-app-tg Target Group UnHealthyHostCount"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  datapoints_to_alarm       = "1"
  period                    = "60"
  metric_name               = "UnHealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  ok_actions                = [var.aws_sns_topic_arn]
  alarm_actions             = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  statistic                 = "Maximum"
  threshold                 = "1"
  treat_missing_data        = "missing"

  dimensions = {
    TargetGroup  = var.target_group
    LoadBalancer = var.load_balancer
  }
}