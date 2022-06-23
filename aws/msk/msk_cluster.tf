# MSK Cluster Configuration
resource "aws_msk_configuration" "cluster_config" {
  kafka_versions = ["2.6.2"]
  name           = "msk-cluster-configuration"

  server_properties = <<PROPERTIES
auto.create.topics.enable = true
delete.topic.enable = true
default.replication.factor = 3
PROPERTIES
}

resource "aws_msk_cluster" "main" {
  cluster_name           = "broker-cluster"
  kafka_version          = "2.6.2"
  number_of_broker_nodes = 3

  broker_node_group_info {
    instance_type   = "kafka.m5.large"
    ebs_volume_size = 1000
    client_subnets = [
      data.aws_subnets.private.ids[0],
      data.aws_subnets.private.ids[1],
      data.aws_subnets.private.ids[2],
    ]
    security_groups = [data.terraform_remote_state.ec2.outputs.security_group_broker]
  }

  client_authentication {
    sasl {
      iam = true
      scram = false
    }
  }

  /* encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.kms.arn
  } */

  /* enhanced_monitoring LEVEL
  DEFAULT
  PER_BROKER
  PER_TOPIC_PER_BROKER
  PER_TOPIC_PER_PARTITION
  */
  enhanced_monitoring = "PER_BROKER"

  /* open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  } */

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.broker_logs.name
      }
      /* firehose {
        enabled         = true
        delivery_stream = aws_kinesis_firehose_delivery_stream.test_stream.name
      }
      s3 {
        enabled = true
        bucket  = aws_s3_bucket.bucket.id
        prefix  = "logs/msk-"
      } */
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "${var.env_name[terraform.workspace]}"
  }
}

/* output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.main.bootstrap_brokers_tls
} */