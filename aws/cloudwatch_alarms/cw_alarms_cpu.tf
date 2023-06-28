resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
  for_each                  = toset(data.aws_instances.all_ec2.ids)
  alarm_description         = "Average EC2 CPU utilization over last 5 minutes too high"
  alarm_name                = "${data.aws_instance.each_ec2[each.key].tags["Name"]} EC2 HighCPUUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  datapoints_to_alarm       = "2"
  period                    = "60"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  ok_actions                = [var.aws_sns_topic_arn]
  alarm_actions             = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  statistic                 = "Average"
  threshold                 = "80"
  treat_missing_data        = "missing"

  dimensions = {
    InstanceId = each.value
  }
}