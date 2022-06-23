# MSK Connect Connector
resource "aws_mskconnect_connector" "es_sink_connect_users" {
  name = "jdbc-sink-connect-sync-users"

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
    "name" : "elasticsearch-sink-sync-users",
    "connection.url" : "${data.terraform_remote_state.opensearch.outputs.cluster_endpoint}",
    "connection.username" : "${data.terraform_remote_state.ecs.outputs.es_username_parameter}",
    "connection.password" : "${data.terraform_remote_state.ecs.outputs.es_password_parameter}",
    "connector.class" : "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
    "type.name" : "kafka-connect",
    "tasks.max" : "1",
    "topics" : "sync_users",
    "key.ignore" : "false",
    "transforms" : "createKey, extractString, dropPrefix, replaceField",
    "transforms.createKey.type" : "org.apache.kafka.connect.transforms.ValueToKey",
    "transforms.createKey.fields" : "id",
    "transforms.extractString.type" : "org.apache.kafka.connect.transforms.ExtractField$Key",
    "transforms.extractString.field" : "id",
    "transforms.dropPrefix.type" : "org.apache.kafka.connect.transforms.RegexRouter",
    "transforms.dropPrefix.regex" : "sync_(.*)",
    "transforms.dropPrefix.replacement" : "$1",
    "transforms.replaceField.type" : "org.apache.kafka.connect.transforms.ReplaceField$Value",
    "transforms.replaceField.blacklist" : "password",
    "value.converter" : "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable" : true
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
      arn      = data.aws_mskconnect_custom_plugin.confluent_elasticsearch_connect.arn
      revision = data.aws_mskconnect_custom_plugin.confluent_elasticsearch_connect.latest_revision
    }
  }

  worker_configuration {
    arn      = data.aws_mskconnect_worker_configuration.confluent_worker.arn
    revision = data.aws_mskconnect_worker_configuration.confluent_worker.latest_revision
  }

  service_execution_role_arn = data.aws_iam_role.MSKConnect_AccessRole.arn
}