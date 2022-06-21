# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "web" {
  name              = "/ecs/web-${var.env_name[terraform.workspace]}"
  retention_in_days = var.retention_in_days[terraform.workspace]

  tags = {
    Environment = "${var.env_name[terraform.workspace]}"
    Terraform   = "true"
  }
}