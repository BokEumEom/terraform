# module "ec2_instance" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "~> 3.0"

#   name = "kafka_test"

#   ami                         = "ami-xxxxxxxxxxxxxxxxx"
#   instance_type               = "t3.large"
#   key_name                    = "keyr"
#   monitoring                  = true
#   vpc_security_group_ids      = aws_security_group.kafka_sg.id
#   subnet_id                   = data.aws_subnets.public.ids[0]
#   associate_public_ip_address = true
#   iam_instance_profile        = "ec2-dev-role"

#   root_block_device = [
#     {
#       delete_on_termination = "true"
#       encrypted             = "false"
#       iops                  = "3000"

#       volume_type = "gp3"
#       throughput  = 125
#       volume_size = 100
#     }
#   ]

#   tags = {
#     Terraform   = "true"
#     Environment = "${var.env_name[terraform.workspace]}"
#   }
# }

resource "aws_instance" "kafka_instance" {
  ami                         = "ami-xxxxxxxxxxxxxx"
  associate_public_ip_address = "true"

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_core_count       = "1"
  cpu_threads_per_core = "2"

  credit_specification {
    cpu_credits = "unlimited"
  }

  disable_api_termination = "false"
  ebs_optimized           = "true"

  enclave_options {
    enabled = "false"
  }

  get_password_data                    = "false"
  hibernation                          = "false"
  iam_instance_profile                 = "ec2-dev-role"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.large"
  ipv6_address_count                   = "0"
  key_name                             = "key"

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = "1"
    http_tokens                 = "optional"
  }

  monitoring = "true"

  root_block_device {
    delete_on_termination = "true"
    encrypted             = "false"
    iops                  = "3000"

    tags = {
      Name = "kafka_test"
    }

    throughput  = "125"
    volume_size = "300"
    volume_type = "gp3"
  }

  source_dest_check = "true"
  subnet_id         = data.aws_subnets.public.ids[0]

  tags = {
    Name    = "kafka_test"
    Product = "kafka"
  }

  tags_all = {
    Name    = "kafka_test"
    Product = "kafka"
  }

  tenancy                = "default"
  vpc_security_group_ids = aws_security_group.kafka_sg.id
}

resource "aws_eip" "kafka" {
  instance = aws_instance.kafka_instance.id
  vpc      = true

  tags = {
    Name = "kafka_test"
  }

  tags_all = {
    Name = "kafka_test"
  }
}