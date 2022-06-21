# Autoscaling
module "autoscaling" {
  source = "../modules/ecs_appautoscaling"

  cluster_name     = aws_ecs_cluster.cluster.name
  service_name     = aws_ecs_service.web.name
  min_capacity     = 1
  max_capacity     = 4
  cpu_target_value = 60
  mem_target_value = 60
  role_arn         = data.aws_iam_role.AutoScaling_ECSService.arn
}