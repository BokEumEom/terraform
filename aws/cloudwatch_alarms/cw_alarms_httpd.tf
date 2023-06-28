resource "aws_cloudwatch_metric_alarm" "httpd_process_status_check" {
  for_each                  = local.all_ec2
  alarm_description         = "This metric monitors httpd process status check."
  alarm_name                = "${each.key} EC2 HttpdStatusCheckFailed"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "1"
  datapoints_to_alarm       = "1"
  period                    = "60"
  metric_name               = "procstat_lookup_pid_count"
  namespace                 = "CWAgent"
  ok_actions                = [var.aws_sns_topic_arn]
  alarm_actions             = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  statistic                 = "Maximum"
  threshold                 = "0"
  treat_missing_data        = "breaching"

  dimensions = {
    ImageId      = each.value.ImageId
    InstanceId   = each.value.InstanceId
    InstanceType = each.value.InstanceType
    pid_finder   = each.value.pid_finder
    exe          = each.value.exe
  }
}