locals {
  thresholds = {
    # DiskUsageThreshold         = floor(min(max(var.disk_usage_threshold, 0), 100))
    CPUUtilizationThreshold    = floor(min(max(var.cpu_utilization_threshold, 0), 100))
    # MemoryUtilizationThreshold = floor(min(max(var.mem_utilization_threshold, 0), 100))
  }
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  count                     = var.monitor_status_check_failed ? 1 : 0
  alarm_description         = "This metric monitors ec2 status check."
  alarm_name                = "${var.alarm_name_prefix} ${var.alarm_name_env} EC2 ${var.alarm_name_postfix} StatusCheckFailed"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = var.alarm_status_check_failed_periods
  datapoints_to_alarm       = var.alarm_status_check_failed_periods
  period                    = var.alarm_status_check_failed_period
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  ok_actions                = [local.aws_sns_topic_arn]
  alarm_actions             = [local.aws_sns_topic_arn]
  insufficient_data_actions = [local.aws_sns_topic_arn]
  statistic                 = "Maximum"
  threshold                 = "0.99"
  treat_missing_data        = "breaching"

  dimensions = {
    InstanceId = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
  count                     = var.monitor_cpu_utilization_too_high ? 1 : 0
  alarm_description         = "Average EC2 CPU utilization over last 5 minutes too high"
  alarm_name                = "${var.alarm_name_prefix} ${var.alarm_name_env} EC2 ${var.alarm_name_postfix} highCPUUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = var.alarm_cpu_utilization_too_high_periods
  datapoints_to_alarm       = var.alarm_cpu_utilization_too_high_periods
  period                    = var.alarm_cpu_utilization_too_high_period
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  ok_actions                = [local.aws_sns_topic_arn]
  alarm_actions             = [local.aws_sns_topic_arn]
  insufficient_data_actions = [local.aws_sns_topic_arn]
  statistic                 = "Average"
  threshold                 = local.thresholds["CPUUtilizationThreshold"]
  treat_missing_data        = "missing"

  dimensions = {
    InstanceId = var.instance_id
  }
}

# resource "aws_cloudwatch_metric_alarm" "mem_utilization_too_high" {
#   count                     = var.monitor_mem_utilization_too_high ? 1 : 0
#   alarm_description         = "Average EC2 Memory utilization over last 5 minutes too high"
#   alarm_name                = "${var.alarm_name_prefix} ${var.alarm_name_env} EC2 ${var.alarm_name_postfix} highMEMUtilization"
#   comparison_operator       = "GreaterThanOrEqualToThreshold"
#   evaluation_periods        = var.alarm_mem_utilization_too_high_periods
#   datapoints_to_alarm       = var.alarm_mem_utilization_too_high_periods
#   period                    = var.alarm_mem_utilization_too_high_period
#   metric_name               = "mem_used_percent"
#   namespace                 = "CWAgent"
#   ok_actions                = [local.aws_sns_topic_arn]
#   alarm_actions             = [local.aws_sns_topic_arn]
#   insufficient_data_actions = [local.aws_sns_topic_arn]
#   statistic                 = "Average"
#   threshold                 = local.thresholds["MemoryUtilizationThreshold"]
#   treat_missing_data        = "missing"

#   dimensions = {
#     ImageId      = var.image_id
#     InstanceId   = var.instance_id
#     InstanceType = var.instance_type
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "disk_usage_too_high" {
#   count                     = var.monitor_disk_usage_too_high ? 1 : 0
#   alarm_description         = "Average EC2 Disk utilization over last 5 minutes too high"
#   alarm_name                = "${var.alarm_name_prefix} ${var.alarm_name_env} EC2 ${var.alarm_name_postfix} highDiskUsage ${var.alarm_name_path}"
#   comparison_operator       = "GreaterThanOrEqualToThreshold"
#   evaluation_periods        = var.alarm_disk_usage_too_high_periods
#   datapoints_to_alarm       = var.alarm_disk_usage_too_high_periods
#   period                    = var.alarm_disk_usage_too_high_period
#   metric_name               = "disk_used_percent"
#   namespace                 = "CWAgent"
#   ok_actions                = [local.aws_sns_topic_arn]
#   alarm_actions             = [local.aws_sns_topic_arn]
#   insufficient_data_actions = [local.aws_sns_topic_arn]
#   statistic                 = "Average"
#   threshold                 = local.thresholds["DiskUsageThreshold"]
#   treat_missing_data        = "missing"

#   dimensions = {
#     ImageId      = var.image_id
#     InstanceId   = var.instance_id
#     InstanceType = var.instance_type
#     device       = var.device
#     fstype       = var.fstype
#     path         = var.mount_path
#   }
# }