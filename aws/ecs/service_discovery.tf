// Comment-out this whole file to disable Service Discovery
resource "aws_service_discovery_private_dns_namespace" "cloud_map" {
  name        = "web.${var.env_name[terraform.workspace]}"
  description = "${var.product_name}-${var.env_name[terraform.workspace]}"
  vpc         = data.aws_vpc.bubbletap.id

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}

resource "aws_service_discovery_service" "web" {
  name = "web"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.cloud_map.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}