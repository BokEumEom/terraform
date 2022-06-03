data "aws_instances" "all_ec2" {
  instance_state_names = ["running"]

  instance_tags = {
    Windows = "2016"
  }
}

data "aws_instance" "each_ec2" {
  for_each    = toset(data.aws_instances.all_ec2.ids)
  instance_id = each.key
}


resource "aws_cloudwatch_metric_alarm" "ebs_disk_capacity" {
  for_each                  = toset(data.aws_instances.all_ec2.ids)
  alarm_name                = "FreeDiskPercentage - ${data.aws_instance.each_ec2[each.key].tags["Name"]}"
  alarm_description         = "The volume is nearly full (default: disk space is <= 10%)."
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 1
  threshold                 = 10
  period                    = 60
  namespace                 = "CWAgent"
  metric_name               = "LogicalDisk % Free Space"
  statistic                 = "Maximum"
  alarm_actions             = [var.notification_topic]
  insufficient_data_actions = [var.notification_topic]
  ok_actions                = [var.notification_topic]
  dimensions = {
    InstanceId   = each.value,
    objectname   = "LogicalDisk",
    instance     = "C:" # <-- HARDCODED, THIS NEEDS TO BE AUTOMATIC 
    ImageId      = data.aws_instance.each_ec2[each.key].ami,
    InstanceType = data.aws_instance.each_ec2[each.key].instance_type
  }
}