resource "aws_ecs_cluster" "cluster" {
  name = "${var.product_name}-${var.env_name[terraform.workspace]}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}

resource "aws_ecs_cluster_capacity_providers" "cluster" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}