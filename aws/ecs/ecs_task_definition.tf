# ECS Task Definition
resource "aws_ecs_task_definition" "web" {
  family                   = "web-${var.env_name[terraform.workspace]}"
  task_role_arn            = var.ecs_task
  execution_role_arn       = var.ecs_task_execution_role
  network_mode             = "awsvpc"
  cpu                      = var.container_cpu[terraform.workspace]
  memory                   = var.container_memory[terraform.workspace]
  requires_compatibilities = ["FARGATE"]

  container_definitions = templatefile("./templates/task_def_web.json", {
    repository_url    = "${data.aws_ecr_repository.web.repository_url}:${var.image_tag[terraform.workspace]}"
    app_cpu           = var.container_cpu[terraform.workspace]
    app_memory        = var.container_memory[terraform.workspace]
    awslogs_group     = "${aws_cloudwatch_log_group.web.name}"
    database_password = "${aws_ssm_parameter.database_password_parameter.arn}"
    database_user     = "${aws_ssm_parameter.database_username_parameter.arn}"
  })


  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}