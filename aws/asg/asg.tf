resource "aws_autoscaling_group" "ecs_autoscaling_group" {
  capacity_rebalance        = "false"
  default_cooldown          = "300"
  desired_capacity          = "1"
  force_delete              = "true"
  health_check_grace_period = "300"
  health_check_type         = "EC2"

  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "1"
  }

  max_instance_lifetime   = "0"
  max_size                = "5"
  metrics_granularity     = "1Minute"
  min_size                = "1"
  name                    = "ECS-Cluster-AutoScalingGroup-${var.node_env[terraform.workspace]}"
  protect_from_scale_in   = "true"
  service_linked_role_arn = "arn:aws:iam::account:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }

  vpc_zone_identifier       = data.aws_subnet_ids.private.ids
  wait_for_capacity_timeout = "10m"
}