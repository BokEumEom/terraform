resource "aws_cloudwatch_metric_alarm" "disk_usage_too_high" {
  for_each                  = local.all_ec2
  alarm_description         = "Average EC2 Disk utilization over last 5 minutes too high"
  alarm_name                = "${each.key} EC2 HighDiskUsage ${each.value.path}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  datapoints_to_alarm       = "2"
  period                    = "60"
  metric_name               = "disk_used_percent"
  namespace                 = "CWAgent"
  ok_actions                = [var.aws_sns_topic_arn]
  alarm_actions             = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  statistic                 = "Average"
  threshold                 = "80"
  treat_missing_data        = "missing"

  dimensions = {
    ImageId      = each.value.ImageId
    InstanceId   = each.value.InstanceId
    InstanceType = each.value.InstanceType
    device       = each.value.device
    fstype       = each.value.fstype
    path         = each.value.path
  }
}