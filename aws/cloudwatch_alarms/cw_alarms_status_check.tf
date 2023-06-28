data "aws_instances" "all_ec2" {
  instance_state_names = ["running"]

  instance_tags = {
    Env = "Prod"
  }
}

data "aws_instance" "each_ec2" {
  for_each    = toset(data.aws_instances.all_ec2.ids)
  instance_id = each.key
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  for_each                  = toset(data.aws_instances.all_ec2.ids)
  alarm_description         = "This metric monitors ec2 status check."
  alarm_name                = "${data.aws_instance.each_ec2[each.key].tags["Name"]} EC2 StatusCheckFailed"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  datapoints_to_alarm       = "1"
  period                    = "60"
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  ok_actions                = [var.aws_sns_topic_arn]
  alarm_actions             = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  statistic                 = "Maximum"
  threshold                 = "0.99"
  treat_missing_data        = "breaching"

  dimensions = {
    InstanceId = each.value
  }
}