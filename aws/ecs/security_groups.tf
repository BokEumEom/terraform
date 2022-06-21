resource "aws_security_group" "web_sg" {
  description = "${var.product_name} ${var.env_name[terraform.workspace]} ecs service security group"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    description     = "Allow inbound access to ECS from the ALB only"
    from_port       = "0"
    protocol        = "-1"
    security_groups = aws_security_group.web_alb_sg.id
    self            = "false"
    to_port         = "0"
  }

  name = "${var.product_name}-${var.env_name[terraform.workspace]}-ecs-fargate-sg"

  tags = {
    Name        = "${var.product_name}-${var.env_name[terraform.workspace]}-ecs-fargate-sg\t"
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }

  tags_all = {
    Name        = "${var.product_name}-${var.env_name[terraform.workspace]}-ecs-fargate-sg\t"
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }

  vpc_id = data.aws_vpc.vpc.id
}