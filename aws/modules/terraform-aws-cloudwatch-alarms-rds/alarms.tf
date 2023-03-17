locals {
  thresholds = {
    BurstBalanceThreshold     = min(max(var.burst_balance_threshold, 0), 100)
    CPUUtilizationThreshold   = min(max(var.cpu_utilization_threshold, 0), 100)
    CPUCreditBalanceThreshold = max(var.cpu_credit_balance_threshold, 0)
    DiskQueueDepthThreshold   = max(var.disk_queue_depth_threshold, 0)
    FreeableMemoryThreshold   = max(var.freeable_memory_threshold, 0)
    FreeStorageSpaceThreshold = max(var.free_storage_space_threshold, 0)
    SwapUsageThreshold        = max(var.swap_usage_threshold, 0)
  }
}

resource "aws_cloudwatch_metric_alarm" "burst_balance_too_low" {
  count                     = var.burst_balance_too_low ? 1 : 0
  alarm_name                = "${var.alarm_name_prefix}-${var.alarm_name_env}-RDS-${var.alarm_name_postfix}-BurstBalanceLow"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = var.alarm_burst_balance_too_low_periods
  datapoints_to_alarm       = var.alarm_burst_balance_too_low_periods
  metric_name               = "BurstBalance"
  namespace                 = "AWS/RDS"
  period                    = var.alarm_burst_balance_too_low_period
  statistic                 = "Average"
  threshold                 = local.thresholds["BurstBalanceThreshold"]
  alarm_description         = "Average database storage burst balance over last 10 minutes too low, expect a significant performance drop soon"
  alarm_actions             = [local.aws_sns_topic_arn]
  ok_actions                = [local.aws_sns_topic_arn]
  insufficient_data_actions = [local.aws_sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
  count                     = var.cpu_utilization_too_high ? 1 : 0
  alarm_name                = "${var.alarm_name_prefix}-${var.alarm_name_env}-RDS-${var.alarm_name_postfix}-CPUutilizationHigh"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.alarm_cpu_utilization_too_high_periods
  datapoints_to_alarm       = var.alarm_cpu_utilization_too_high_periods
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = var.alarm_cpu_utilization_too_high_period
  statistic                 = "Average"
  threshold                 = local.thresholds["CPUUtilizationThreshold"]
  alarm_description         = "Average database CPU utilization over last 10 minutes too high"
  alarm_actions             = [local.aws_sns_topic_arn]
  ok_actions                = [local.aws_sns_topic_arn]
  insufficient_data_actions = [local.aws_sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_credit_balance_too_low" {
  count                     = var.cpu_credit_balance_too_low ? 1 : 0
  alarm_name                = "${var.alarm_name_prefix}-${var.alarm_name_env}-RDS-${var.alarm_name_postfix}-CPUcreditBalanceLow"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = var.alarm_cpu_credit_balance_too_low_periods
  datapoints_to_alarm       = var.alarm_cpu_credit_balance_too_low_periods
  metric_name               = "CPUCreditBalance"
  namespace                 = "AWS/RDS"
  period                    = var.alarm_cpu_credit_balance_too_low_period
  statistic                 = "Average"
  threshold                 = local.thresholds["CPUCreditBalanceThreshold"]
  alarm_description         = "Average database CPU credit balance over last 10 minutes too low, expect a significant performance drop soon"
  alarm_actions             = [local.aws_sns_topic_arn]
  ok_actions                = [local.aws_sns_topic_arn]
  insufficient_data_actions = [local.aws_sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "disk_queue_depth_too_high" {
  count                     = var.disk_queue_depth_too_high ? 1 : 0
  alarm_name                = "${var.alarm_name_prefix}-${var.alarm_name_env}-RDS-${var.alarm_name_postfix}-DiskQueuedepthHigh"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.alarm_disk_queue_depth_too_high_periods
  datapoints_to_alarm       = var.alarm_disk_queue_depth_too_high_periods
  metric_name               = "DiskQueueDepth"
  namespace                 = "AWS/RDS"
  period                    = var.alarm_disk_queue_depth_too_high_period
  statistic                 = "Average"
  threshold                 = local.thresholds["DiskQueueDepthThreshold"]
  alarm_description         = "Average database disk queue depth over last 10 minutes too high, performance may suffer"
  alarm_actions             = [local.aws_sns_topic_arn]
  ok_actions                = [local.aws_sns_topic_arn]
  insufficient_data_actions = [local.aws_sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "freeable_memory_too_low" {
  count                     = var.freeable_memory_too_low ? 1 : 0
  alarm_name                = "${var.alarm_name_prefix}-${var.alarm_name_env}-RDS-${var.alarm_name_postfix}-FreeableMemoryLow"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = var.alarm_freeable_memory_too_low_periods
  datapoints_to_alarm       = var.alarm_freeable_memory_too_low_periods
  metric_name               = "FreeableMemory"
  namespace                 = "AWS/RDS"
  period                    = var.alarm_freeable_memory_too_low_period
  statistic                 = "Average"
  threshold                 = local.thresholds["FreeableMemoryThreshold"]
  alarm_description         = "Average database freeable memory over last 10 minutes too low, performance may suffer"
  alarm_actions             = [local.aws_sns_topic_arn]
  ok_actions                = [local.aws_sns_topic_arn]
  insufficient_data_actions = [local.aws_sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "free_storage_space_too_low" {
  count                     = var.free_storage_space_too_low ? 1 : 0
  alarm_name                = "${var.alarm_name_prefix}-${var.alarm_name_env}-RDS-${var.alarm_name_postfix}-FreeStorageSpaceLow"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = var.alarm_free_storage_space_too_low_periods
  datapoints_to_alarm       = var.alarm_free_storage_space_too_low_periods
  metric_name               = "FreeLocalStorage"
  namespace                 = "AWS/RDS"
  period                    = var.alarm_free_storage_space_too_low_period
  statistic                 = "Average"
  threshold                 = local.thresholds["FreeStorageSpaceThreshold"]
  alarm_description         = "Average database free storage space over last 10 minutes too low"
  alarm_actions             = [local.aws_sns_topic_arn]
  ok_actions                = [local.aws_sns_topic_arn]
  insufficient_data_actions = [local.aws_sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "swap_usage_too_high" {
  count                     = var.swap_usage_too_high ? 1 : 0
  alarm_name                = "${var.alarm_name_prefix}-${var.alarm_name_env}-RDS-${var.alarm_name_postfix}-SwapUsageHigh"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.alarm_swap_usage_too_high_periods
  datapoints_to_alarm       = var.alarm_swap_usage_too_high_periods
  metric_name               = "SwapUsage"
  namespace                 = "AWS/RDS"
  period                    = var.alarm_swap_usage_too_high_period
  statistic                 = "Average"
  threshold                 = local.thresholds["SwapUsageThreshold"]
  alarm_description         = "Average database swap usage over last 10 minutes too high, performance may suffer"
  alarm_actions             = [local.aws_sns_topic_arn]
  ok_actions                = [local.aws_sns_topic_arn]
  insufficient_data_actions = [local.aws_sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "connection_count_anomalous" {
  count                     = var.swap_usage_too_high ? 1 : 0
  alarm_name                = "${var.alarm_name_prefix}-${var.alarm_name_env}-RDS-${var.alarm_name_postfix}-AnomalousConnectionCount"
  comparison_operator       = "GreaterThanUpperThreshold"
  evaluation_periods        = var.alarm_connection_count_anomalous_periods
  threshold_metric_id       = "e1"
  alarm_description         = "Anomalous database connection count detected. Something unusual is happening."
  alarm_actions             = [local.aws_sns_topic_arn]
  ok_actions                = [local.aws_sns_topic_arn]
  insufficient_data_actions = [local.aws_sns_topic_arn]

  metric_query {
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1, 8)"
    label       = "DatabaseConnections (Expected)"
    return_data = "true"
  }

  metric_query {
    id          = "m1"
    return_data = "true"
    metric {
      metric_name = "DatabaseConnections"
      namespace   = "AWS/RDS"
      period      = "600"
      stat        = "Average"
      unit        = "Count"

      dimensions = {
        DBInstanceIdentifier = var.db_instance_id
      }
    }
  }
}