# Creating the Elasticsearch domain

resource "aws_opensearch_domain" "es" {
  domain_name    = "${var.product_name}-es-${var.env_name[terraform.workspace]}-cluster"
  engine_version = "OpenSearch_1.2"

  advanced_security_options {
    enabled                        = "true"
    internal_user_database_enabled = "true"

    master_user_options {
      master_user_name     = local.db_creds.es_username
      master_user_password = local.db_creds.es_password
    }
  }

  cluster_config {
    dedicated_master_enabled = "true"
    instance_count           = 3
    instance_type            = "c6g.large.search"
    zone_awareness_enabled   = "true"

    zone_awareness_config {
      availability_zone_count = 3
    }
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  vpc_options {
    subnet_ids         = data.aws_subnets.private.ids
    security_group_ids = [data.terraform_remote_state.ec2.outputs.security_group_opensearch]
  }

  ebs_options {
    ebs_enabled = "true"
    volume_size = 10
  }

  domain_endpoint_options {
    custom_endpoint_certificate_arn = "arn"
    custom_endpoint_enabled         = "true"
    custom_endpoint                 = "es.${var.env_name[terraform.workspace]}.example.com"
  }

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}

# Creating the AWS Elasticsearch domain policy

resource "aws_opensearch_domain_policy" "main" {
  domain_name     = aws_opensearch_domain.es.domain_name
  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "${aws_opensearch_domain.es.arn}/*"
        }
    ]
}
POLICIES
}