# MSK Connect Connector
resource "aws_mskconnect_connector" "jdbc_sink_connect_sync_users_to_title" {
  name = "jdbc-sink-connect-sync-users-to-title"

  kafkaconnect_version = "2.6.2"

  log_delivery {
    worker_log_delivery {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.sink_connector_logs.name
      }
    }
  }

  capacity {
    autoscaling {
      mcu_count        = 1
      min_worker_count = 1
      max_worker_count = 2

      scale_in_policy {
        cpu_utilization_percentage = 20
      }

      scale_out_policy {
        cpu_utilization_percentage = 80
      }
    }
  }

  connector_configuration = {
    "connector.class" : "io.confluent.connect.jdbc.JdbcSinkConnector",
    "connection.url" : "jdbc:mysql://${data.terraform_remote_state.rds.outputs.cluster_endpoint}:3306/title",
    "connection.user" : "db_user",
    "connection.password" : "db_password",
    "auto.create" : "false",
    "auto.evolve" : "false",
    "delete.enabled" : "false",
    "tasks.max" : "1",
    "topics" : "sync_users",
    "insert.mode" : "upsert",
    "pk.fields" : "id",
    "pk.mode" : "record_value",
    "max.retries" : "10",
    "retry.backoff.ms" : "3000",
    "transforms" : "dropPrefix",
    "transforms.dropPrefix.type" : "org.apache.kafka.connect.transforms.RegexRouter",
    "transforms.dropPrefix.regex" : "sync_(.*)",
    "transforms.dropPrefix.replacement" : "$1",
    "value.converter" : "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable" : "true"
  }

  kafka_cluster {
    apache_kafka_cluster {
      bootstrap_servers = data.terraform_remote_state.msk.outputs.aws_msk_cluster_bootstrap_brokers

      vpc {
        security_groups = [data.terraform_remote_state.ec2.outputs.security_group_broker]
        subnets = [
          data.aws_subnets.private.ids[0],
          data.aws_subnets.private.ids[1],
          data.aws_subnets.private.ids[2],
        ]
      }
    }
  }

  kafka_cluster_client_authentication {
    authentication_type = "IAM"
  }

  kafka_cluster_encryption_in_transit {
    encryption_type = "TLS"
  }

  plugin {
    custom_plugin {
      arn      = data.aws_mskconnect_custom_plugin.confluent_jdbc_connect.arn
      revision = data.aws_mskconnect_custom_plugin.confluent_jdbc_connect.latest_revision
    }
  }

  worker_configuration {
    arn      = data.aws_mskconnect_worker_configuration.confluent_worker.arn
    revision = data.aws_mskconnect_worker_configuration.confluent_worker.latest_revision
  }

  service_execution_role_arn = data.aws_iam_role.MSKConnect_AccessRole.arn
}